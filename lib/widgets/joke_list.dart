import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import '../services/joke_service.dart';

class JokeList extends StatefulWidget {
  const JokeList({super.key});

    @override
    State<JokeList> createState() => _JokeListState();
}

class _JokeListState extends State<JokeList> {
    final JokeService _jokeService = GetIt.instance<JokeService>();
    List<String> _jokes = [];
    bool _isLoading = false;

    @override
    void initState() {
        super.initState();
        _loadJokes();
    }

    Future<void> _loadJokes() async {
        setState(() => _isLoading = true);

        final jokes = await _jokeService.fetchJokes();

        if (mounted) {
            setState(() {
                _jokes = jokes;
                _isLoading = false;
            });
        }
    }

    @override
    Widget build(BuildContext context) {
        if (_isLoading) {
            return const Center(child: CircularProgressIndicator());
        }

        if (_jokes.isEmpty) {
            return const Center(child: Text('Не удалось загрузить шутки'));
        }

        return RefreshIndicator(
                onRefresh: _loadJokes,
                child: ListView.builder(
                itemCount: _jokes.length,
                itemBuilder: (context, index) {
            return ListTile(
                    leading: const Icon(Icons.emoji_emotions_outlined, size: 30),
            title: Text(
                    _jokes[index],
                    style: const TextStyle(fontSize: 16),
            ),
            subtitle: const Text('Батина шутка...', style: TextStyle(color: Colors.grey)),
          );
        },
      ),
    );
    }
}