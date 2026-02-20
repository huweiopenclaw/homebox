import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/auth_notifier.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() => _errorMessage = '请填写邮箱和密码');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final success = await ref.read(authStateProvider.notifier).login(
      _emailController.text,
      _passwordController.text,
    );

    if (mounted) {
      if (success) {
        context.go('/home');
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = '登录失败，请检查邮箱和密码';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('登录')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.inventory_2,
              size: 80,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 24),
            const Text(
              'HomeBox',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text('智能家庭收纳助手'),
            const SizedBox(height: 48),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: '邮箱',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: '密码',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _login,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('登录', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => context.go('/register'),
              child: const Text('没有账号？立即注册'),
            ),
          ],
        ),
      ),
    );
  }
}
