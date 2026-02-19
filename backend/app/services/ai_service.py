"""
AI Service for image recognition and chat
"""
import base64
import httpx
from typing import Optional, List
import json

from ..core.config import settings


class AIService:
    """Service for AI operations using VLM/LLM"""
    
    def __init__(self):
        self.api_key = settings.GLM_API_KEY
        self.api_url = settings.GLM_API_URL
    
    async def _call_glm_api(
        self, 
        messages: List[dict], 
        model: str = "glm-4v-flash",
        temperature: float = 0.7,
        max_tokens: int = 1024
    ) -> str:
        """Call GLM API"""
        if not self.api_key:
            # Return mock response for development
            return self._get_mock_response(messages)
        
        headers = {
            "Authorization": f"Bearer {self.api_key}",
            "Content-Type": "application/json"
        }
        
        payload = {
            "model": model,
            "messages": messages,
            "temperature": temperature,
            "max_tokens": max_tokens
        }
        
        async with httpx.AsyncClient(timeout=60.0) as client:
            response = await client.post(
                self.api_url,
                headers=headers,
                json=payload
            )
            response.raise_for_status()
            data = response.json()
            return data["choices"][0]["message"]["content"]
    
    def _get_mock_response(self, messages: List[dict]) -> str:
        """Return mock response for development without API key"""
        last_message = messages[-1]["content"]
        
        # Check if it's an image recognition request
        if isinstance(last_message, list):
            for item in last_message:
                if item.get("type") == "text" and "识别" in item.get("text", ""):
                    return json.dumps({
                        "items": [
                            {"name": "红色毛衣", "quantity": 2, "confidence": 0.95},
                            {"name": "灰色围巾", "quantity": 1, "confidence": 0.90},
                            {"name": "毛线帽", "quantity": 1, "confidence": 0.88}
                        ],
                        "summary": "箱子中包含冬季衣物，共4件"
                    }, ensure_ascii=False)
        
        # Chat response
        return "您的物品在【冬季衣物-1】箱子中，位于卧室衣柜左侧顶层。"
    
    async def recognize_items(self, image_base64: str) -> dict:
        """
        Recognize items in a box from image
        Returns structured item list
        """
        prompt = """你是一个家庭收纳助手。请分析这张照片中的物品，返回 JSON 格式的物品列表。

要求：
1. 识别所有可见物品
2. 估计每个物品的数量
3. 用中文描述物品名称
4. 如果有颜色，在名称中包含颜色描述
5. confidence 表示识别置信度 (0-1)

返回格式（仅返回 JSON，不要其他内容）：
{
  "items": [
    {"name": "红色毛衣", "quantity": 2, "confidence": 0.95, "note": ""}
  ],
  "summary": "箱子中包含冬季衣物，共X件"
}"""
        
        messages = [
            {
                "role": "user",
                "content": [
                    {
                        "type": "image_url",
                        "image_url": {
                            "url": f"data:image/jpeg;base64,{image_base64}"
                        }
                    },
                    {
                        "type": "text",
                        "text": prompt
                    }
                ]
            }
        ]
        
        try:
            response = await self._call_glm_api(messages, model="glm-4v-flash")
            # Parse JSON response
            result = json.loads(response)
            return result
        except json.JSONDecodeError:
            # If response is not valid JSON, try to extract JSON from text
            import re
            json_match = re.search(r'\{[\s\S]*\}', response)
            if json_match:
                return json.loads(json_match.group())
            raise ValueError("Failed to parse AI response as JSON")
    
    async def recognize_location(self, image_base64: str) -> dict:
        """
        Recognize storage location from image
        Returns location description
        """
        prompt = """你是一个家庭收纳助手。请分析这张照片，描述箱子/物品的存放位置。

要求：
1. 识别房间类型（卧室/客厅/厨房/浴室/储藏室/阳台/书房/玄关）
2. 识别家具（衣柜/书架/抽屉/箱子/床底/橱柜/鞋柜）
3. 描述具体位置（左/右/上/下/中层/角落）
4. landmarks 识别周围标志性物品

返回格式（仅返回 JSON，不要其他内容）：
{
  "room": "卧室",
  "furniture": "衣柜",
  "position": "左侧顶层",
  "description": "卧室衣柜左侧顶层",
  "landmarks": ["窗边", "床头柜旁边"]
}"""
        
        messages = [
            {
                "role": "user",
                "content": [
                    {
                        "type": "image_url",
                        "image_url": {
                            "url": f"data:image/jpeg;base64,{image_base64}"
                        }
                    },
                    {
                        "type": "text",
                        "text": prompt
                    }
                ]
            }
        ]
        
        try:
            response = await self._call_glm_api(messages, model="glm-4v-flash")
            result = json.loads(response)
            return result
        except json.JSONDecodeError:
            import re
            json_match = re.search(r'\{[\s\S]*\}', response)
            if json_match:
                return json.loads(json_match.group())
            raise ValueError("Failed to parse AI response as JSON")
    
    async def chat(
        self, 
        user_message: str, 
        context: Optional[str] = None,
        boxes_info: Optional[List[dict]] = None
    ) -> str:
        """
        Chat with AI assistant about inventory
        """
        system_prompt = """你是 HomeBox 家庭收纳助手，帮助用户管理家中物品的存放位置。

你的功能：
1. 帮助用户查找物品位置
2. 列出某个房间的箱子
3. 统计物品数量
4. 提供收纳建议

回答要求：
- 简洁明了，直接回答用户问题
- 如果找到物品，说明所在箱子名称和具体位置
- 如果没找到，建议用户添加新记录或换种方式搜索
- 使用友好的语气"""

        messages = [
            {"role": "system", "content": system_prompt}
        ]
        
        # Add context if provided
        if context:
            messages.append({"role": "system", "content": f"用户当前的收纳数据：\n{context}"})
        
        messages.append({"role": "user", "content": user_message})
        
        response = await self._call_glm_api(
            messages, 
            model="glm-4-flash",
            temperature=0.7,
            max_tokens=512
        )
        return response
    
    async def classify_intent(self, message: str) -> str:
        """
        Classify user intent from message
        Returns: find_item, list_boxes, count_items, add_item, remove_item, chat
        """
        prompt = f"""分析用户意图，返回以下类别之一：
- find_item: 查找物品位置
- list_boxes: 列出箱子
- count_items: 统计数量
- add_item: 添加物品
- remove_item: 移除物品
- chat: 一般聊天

用户消息：{message}

仅返回意图类别，不要其他内容。"""
        
        response = await self._call_glm_api(
            [{"role": "user", "content": prompt}],
            model="glm-4-flash",
            temperature=0.1,
            max_tokens=20
        )
        return response.strip().lower()
    
    async def extract_entities(self, message: str) -> dict:
        """
        Extract entities from user message
        Returns: {"item": "围巾", "room": "卧室", ...}
        """
        prompt = f"""从用户消息中提取实体，返回 JSON 格式。

用户消息：{message}

返回格式：
{{"item": "物品名称", "room": "房间", "category": "类别"}}
如果没有提取到某个字段，设为 null。仅返回 JSON。"""
        
        response = await self._call_glm_api(
            [{"role": "user", "content": prompt}],
            model="glm-4-flash",
            temperature=0.1,
            max_tokens=100
        )
        
        try:
            return json.loads(response)
        except json.JSONDecodeError:
            import re
            json_match = re.search(r'\{[\s\S]*\}', response)
            if json_match:
                return json.loads(json_match.group())
            return {}


# Singleton instance
ai_service = AIService()
