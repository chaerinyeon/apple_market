import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class AuthProvider with ChangeNotifier {
  String? _userid;
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String? get userid => _userid;

  final Map<String, String> _users = {};

  late String _logFilePath;
  late String _userListFilePath;

  AuthProvider() {
    _initLogFiles();
  }

  void _initLogFiles() async {
    final directory = await getApplicationDocumentsDirectory();
    _logFilePath = '${directory.path}/auth_logs.txt';
    _userListFilePath = '${directory.path}/user_list.txt';

    await _loadUserList();
  }

  Future<void> _writeLog(String message) async {
    final file = File(_logFilePath);
    final timestamp = DateTime.now().toIso8601String();
    await file.writeAsString('[$timestamp] $message\n', mode: FileMode.append);
  }

  Future<void> _saveUserList() async {
    final file = File(_userListFilePath);
    final userList =
        _users.entries.map((e) => '${e.key}:${e.value}').join('\n');
    await file.writeAsString(userList);
  }

  Future<void> _loadUserList() async {
    final file = File(_userListFilePath);
    if (await file.exists()) {
      final contents = await file.readAsString();
      final lines = contents.split('\n');
      for (var line in lines) {
        if (line.trim().isEmpty) continue;
        final parts = line.split(':');
        if (parts.length == 2) {
          final userid = parts[0];
          final password = parts[1];
          _users[userid] = password;
        }
      }
    }
  }

  Future<String> readLogs() async {
    try {
      final file = File(_logFilePath);
      String logs = await file.readAsString();
      return logs;
    } catch (e) {
      return '로그를 불러오는 중 오류가 발생했습니다.';
    }
  }

  Future<bool> register(String userid, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    if (_users.containsKey(userid)) {
      _errorMessage = '이미 존재하는 아이디입니다.';
      await _writeLog('회원가입 실패 - 아이디 중복: $userid');
      _isLoading = false;
      notifyListeners();
      return false;
    } else {
      _users[userid] = password;
      await _saveUserList();
      await _writeLog('회원가입 성공: $userid');
      _isLoading = false;
      notifyListeners();
      return true;
    }
  }

  Future<bool> login(String userid, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));
    if (_users.containsKey(userid) && _users[userid] == password) {
      _userid = userid;
      await _writeLog('로그인 성공: $userid');
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _errorMessage = '아이디 또는 비밀번호가 올바르지 않습니다.';
      await _writeLog('로그인 실패: $userid');
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _userid = null;
    notifyListeners();
  }
}
