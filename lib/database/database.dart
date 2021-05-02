import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/activity.dart';
import '../models/reward.dart';

final _defaultRewards = [
  Reward(
    id: 1,
    name: 'Eat your favorite dessert',
    emoji: '🍰',
  ),
  Reward(
    id: 2,
    name: 'Go to your favorite restaurant',
    emoji: '🥙',
  ),
  Reward(
    id: 3,
    name: 'Take rest',
    emoji: '😴',
  ),
  Reward(
    id: 4,
    name: 'Take a day off',
    emoji: '🎮',
  ),
  Reward(
    id: 5,
    name: 'Buy something for yourself',
    emoji: '🛒',
  ),
  Reward(
    id: 6,
    name: 'Personal Praise',
    emoji: '🙌',
  ),
];

final _defaultActivities = [
  Activity(
    id: 1,
    name: 'Watch TV',
    description: 'Rewatch your favorite movie or TV show',
    emoji: '🎞',
    credits: 2,
  ),
  Activity(
    id: 2,
    name: 'Music',
    description: 'Listen to your favorite music and sing along',
    emoji: '🎵',
    credits: 1,
  ),
  Activity(
    id: 3,
    name: 'Exercise',
    description: 'Scientifically proven way to be more happy',
    emoji: '🏋️‍♀️',
    credits: 3,
  ),
  Activity(
    id: 4,
    name: 'Create Art',
    description: 'Let your creativity flow in any form of art!',
    emoji: '🎨',
    credits: 2,
  ),
  Activity(
    id: 5,
    name: 'Pet',
    description: 'Spending time with animals releases dopamine',
    emoji: '🐶',
    credits: 1,
  ),
  Activity(
    id: 6,
    name: 'Write',
    description: 'Vent your anxiety through writing',
    emoji: '✍',
    credits: 3,
  ),
  Activity(
    id: 7,
    name: 'Cook',
    description: 'Make your comfort food',
    emoji: '🍳',
    credits: 3,
  ),
  Activity(
    id: 8,
    name: 'Talk to a friend',
    description: 'Make a call or have an in-person meeting',
    emoji: '🗣',
    credits: 3,
  ),
  Activity(
    id: 9,
    name: 'Donate',
    description: 'Helping others helps you to feel better',
    emoji: '😇',
    credits: 4,
  ),
  Activity(
    id: 10,
    name: 'Meditate',
    description: 'Do 10 sets of breathing exercises',
    emoji: '🧘',
    credits: 2,
  ),
  Activity(
    id: 11,
    name: 'Reminisce',
    description: 'Sometimes recollecting old memories help',
    emoji: '⌚',
    credits: 2,
  ),
  Activity(
    id: 12,
    name: 'Take selfie',
    description: 'A little self love goes a long way!',
    emoji: '🤳',
    credits: 1,
  ),
  Activity(
    id: 13,
    name: 'Read',
    description: 'Escape this reality to a fantasy world!',
    emoji: '📚',
    credits: 4,
  ),
];

Future<Database> connectToDB(String dbName) async {
  try {
    return await openDatabase(
      join(await getDatabasesPath(), '$dbName.db'),
      onCreate: (db, version) async {
        try {
          final batch = db.batch();

          // Create and insert default rewards into database.
          batch.execute(
              'CREATE TABLE IF NOT EXISTS rewards(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, emoji TEXT NOT NULL);');
          _defaultRewards.forEach((reward) {
            batch.insert('rewards', reward.toMap());
          });

          // Create and insert default activities into database.
          batch.execute(
              'CREATE TABLE IF NOT EXISTS activities(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, description TEXT NOT NULL, emoji TEXT NOT NULL, credits INTEGER NOT NULL);');
          _defaultActivities.forEach((activity) {
            batch.insert('activities', activity.toMap());
          });

          // Create challenges table.
          batch.execute(
              "CREATE TABLE IF NOT EXISTS challenges(id INTEGER PRIMARY KEY AUTOINCREMENT, initial_level INTEGER NOT NULL, ideal_level INTEGER NOT NULL, updated_level INTEGER, reward_id INTEGER NOT NULL, created_at INTEGER NOT NULL, remind_at INTEGER NOT NULL, condition TEXT NOT NULL, FOREIGN KEY(reward_id) REFERENCES rewards(id));");

          // Create challenges_activities table.
          batch.execute(
              'CREATE TABLE IF NOT EXISTS challenges_activities(id INTEGER PRIMARY KEY AUTOINCREMENT, challenge_id INTEGER NOT NULL, activity_id INTEGER NOT NULL)');

          await batch.commit();
        } catch (err) {
          throw err;
        }
      },
      version: 2,
    );
  } catch (err) {
    throw err;
  }
}
