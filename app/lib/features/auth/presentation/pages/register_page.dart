import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/auth_notifier.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nicknameController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() => _errorMessage = '请填写邮箱和密码');
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() => _errorMessage = '两次密码输入不一致');
      return;
    }

    if (_passwordController.text.length < 6) {
      setState(() => _errorMessage = '密码至少6位');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final success = await ref.read(authStateProvider.notifier).register(
      _emailController.text,
      _passwordController.text,
      _nicknameController.text.isEmpty ? null : _nicknameController.text,
    );

    if (mounted) {
      if (success) {
        context.go('/home');
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = '注册失败，邮箱可能已被使用';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('注册')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 24),
            const Icon(
              Icons.inventory_2,
              size: 64,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 16),
            const Text('创建账号', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 32),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: '邮箱 *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nicknameController,
              decoration: const InputDecoration(
                labelText: '昵称',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: '密码 *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(
                labelText: '确认密码 *',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock_outline),
              ),
              obscureText: true,
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
            ],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _register,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('注册', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => context.go('/login'),
              child: const Text('已有账号？立即登录'),
            ),
          ],
        ),
      ),
    );
  }
}
