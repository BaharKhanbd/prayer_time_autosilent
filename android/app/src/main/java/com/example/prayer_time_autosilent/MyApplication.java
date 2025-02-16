package com.example.prayer_time_autosilent;

import android.app.NotificationManager;
import android.content.Context;
import android.media.AudioManager;
import android.os.Build;
import android.widget.Toast;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "silent_mode";

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
            .setMethodCallHandler((call, result) -> {
                if (call.method.equals("enableSilent")) {
                    enableSilentMode();
                    result.success("Silent Mode Enabled");
                } else if (call.method.equals("disableSilent")) {
                    disableSilentMode();
                    result.success("Silent Mode Disabled");
                } else {
                    result.notImplemented();
                }
            });
    }

    private void enableSilentMode() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            NotificationManager notificationManager =
                (NotificationManager) getSystemService(Context.NOTIFICATION_SERVICE);

            if (!notificationManager.isNotificationPolicyAccessGranted()) {
                Toast.makeText(this, "DND পারমিশন প্রয়োজন!", Toast.LENGTH_LONG).show();
                return;
            }
        }

        AudioManager audioManager = (AudioManager) getSystemService(Context.AUDIO_SERVICE);
        audioManager.setRingerMode(AudioManager.RINGER_MODE_SILENT);
        Toast.makeText(this, "Silent Mode ON", Toast.LENGTH_SHORT).show();
    }

    private void disableSilentMode() {
        AudioManager audioManager = (AudioManager) getSystemService(Context.AUDIO_SERVICE);
        audioManager.setRingerMode(AudioManager.RINGER_MODE_NORMAL);
        Toast.makeText(this, "Silent Mode OFF", Toast.LENGTH_SHORT).show();
    }
}
