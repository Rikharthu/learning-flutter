import 'dart:math';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/gestures.dart';
import 'package:langaw/View.dart';
import 'package:langaw/components/agile-fly.dart';
import 'package:langaw/components/backyard.dart';
import 'package:langaw/components/credits-button.dart';
import 'package:langaw/components/drooler-fly.dart';
import 'package:langaw/components/fly.dart';
import 'package:langaw/components/help-button.dart';
import 'package:langaw/components/highscore-display.dart';
import 'package:langaw/components/house-fly.dart';
import 'package:langaw/components/hungy-fly.dart';
import 'package:langaw/components/macho-fly.dart';
import 'package:langaw/components/music-button.dart';
import 'package:langaw/components/score-display.dart';
import 'package:langaw/components/sound-button.dart';
import 'package:langaw/components/start-button.dart';
import 'package:langaw/controllers/spawner.dart';
import 'package:langaw/views/credits-view.dart';
import 'package:langaw/views/help-view.dart';
import 'package:langaw/views/home-view.dart';
import 'package:langaw/views/lost-view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LangawGame extends Game {
  Size screenSize;
  double tileSize;
  List<Fly> flies;
  Backyard background;
  Random rnd;
  View activeView = View.home;
  HomeView homeView;
  LostView lostView;
  StartButton startButton;
  HelpButton helpButton;
  CreditsButton creditsButton;
  HelpView helpView;
  CreditsView creditsView;
  ScoreDisplay scoreDisplay;
  HighscoreDisplay highscoreDisplay;
  FlySpawner spawner;
  int score;
  final SharedPreferences storage;
  AudioPlayer homeBGM;
  AudioPlayer playingBGM;
  MusicButton musicButton;
  SoundButton soundButton;

  LangawGame(this.storage) {
    initialize();
  }

  void initialize() async {
    flies = List<Fly>();
    rnd = Random();
    resize(await Flame.util.initialDimensions());
    background = Backyard(this);
    homeView = HomeView(this);
    lostView = LostView(this);
    helpView = HelpView(this);
    creditsView = CreditsView(this);
    startButton = StartButton(this);
    helpButton = HelpButton(this);
    creditsButton = CreditsButton(this);
    scoreDisplay = ScoreDisplay(this);
    highscoreDisplay = HighscoreDisplay(this);
    spawner = FlySpawner(this);

    homeBGM = await Flame.audio.loop('bgm/home.mp3', volume: .25);
    homeBGM.pause();
    playingBGM = await Flame.audio.loop('bgm/playing.mp3', volume: .25);
    playingBGM.pause();

    musicButton = MusicButton(this);
    soundButton = SoundButton(this);

    playHomeBGM();
  }

  @override
  void render(Canvas canvas) {
    // Draw background
//    Rect bgRect = Rect.fromLTWH(0, 0, screenSize.width, screenSize.height);
//    Paint bgPaint = Paint();
//    bgPaint.color = Color(0xff576574);
//    canvas.drawRect(bgRect, bgPaint);
    background.render(canvas);

    // Highscore display
    highscoreDisplay.render(canvas);

    // Score display
    if (activeView == View.playing) scoreDisplay.render(canvas);

    // Draw flies
    flies.forEach((Fly fly) => fly.render(canvas));

    if (activeView == View.home) homeView.render(canvas);
    if (activeView == View.lost) lostView.render(canvas);
    if (activeView == View.home || activeView == View.lost) {
      startButton.render(canvas);
      helpButton.render(canvas);
      creditsButton.render(canvas);
    }

    // Music buttons
    musicButton.render(canvas);
    soundButton.render(canvas);

    // Dialog boxes
    if (activeView == View.help) helpView.render(canvas);
    if (activeView == View.credits) creditsView.render(canvas);
  }

  // Called about 60 times per second
  @override
  void update(double timeDelta) {
    // timeDelta => time passed since the last time update was run (in seconds)
    // Update flies
    flies.forEach((Fly fly) => fly.update(timeDelta));
    flies.removeWhere((Fly fly) => fly.isOffScreen);
    spawner.update(timeDelta);

    // score display
    if (activeView == View.playing) scoreDisplay.update(timeDelta);
  }

  @override
  void resize(Size size) {
    this.screenSize = size;
    this.tileSize = this.screenSize.width / 9;
  }

  void onTapDown(TapDownDetails d) {
    bool isHandled = false;

    // dialog boxes
    if (!isHandled) {
      if (activeView == View.help || activeView == View.credits) {
        activeView = View.home;
        isHandled = true;
      }
    }

    // start button
    if (!isHandled && startButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        print("Start button clicked");
        startButton.onTapDown();
        isHandled = true;
      }
    }

    // help button
    if (!isHandled && helpButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        helpButton.onTapDown();
        isHandled = true;
      }
    }

    // credits button
    if (!isHandled && creditsButton.rect.contains(d.globalPosition)) {
      if (activeView == View.home || activeView == View.lost) {
        creditsButton.onTapDown();
        isHandled = true;
      }
    }

    // music button
    if (!isHandled && musicButton.rect.contains(d.globalPosition)) {
      musicButton.onTapDown();
      isHandled = true;
    }

    // sound button
    if (!isHandled && soundButton.rect.contains(d.globalPosition)) {
      soundButton.onTapDown();
      isHandled = true;
    }

    // flies
    if (!isHandled) {
      bool didHitAFly = false;

      flies.forEach((Fly fly) {
        if (fly.flyRect.contains(d.globalPosition)) {
          fly.onTapDown();
          didHitAFly = true;
          isHandled = true;
        }
      });

      if (activeView == View.playing && !didHitAFly) {
        if (soundButton.isEnabled) {
          Flame.audio.play('sfx/haha' + (rnd.nextInt(5) + 1).toString() + '.ogg');
        }
        activeView = View.lost;
      }
    }
  }

  void spawnFly() {
//    double x = rnd.nextDouble() * (screenSize.width - (tileSize * 2.025));
//    double y = rnd.nextDouble() * (screenSize.height - (tileSize * 2.025));
    double x = rnd.nextDouble() * (screenSize.width - (tileSize * 1.35));
    double y = (rnd.nextDouble() * (screenSize.height - (tileSize * 2.85))) + (tileSize * 1.5);
    switch (rnd.nextInt(5)) {
      case 0:
        flies.add(HouseFly(this, x, y));
        break;
      case 1:
        flies.add(DroolerFly(this, x, y));
        break;
      case 2:
        flies.add(AgileFly(this, x, y));
        break;
      case 3:
        flies.add(MachoFly(this, x, y));
        break;
      case 4:
        flies.add(HungryFly(this, x, y));
        break;
    }
  }

  void playHomeBGM() {
    playingBGM.pause();
    playingBGM.seek(Duration.zero);
    homeBGM.resume();
  }

  void playPlayingBGM() {
    homeBGM.pause();
    homeBGM.seek(Duration.zero);
    playingBGM.resume();
  }
}
