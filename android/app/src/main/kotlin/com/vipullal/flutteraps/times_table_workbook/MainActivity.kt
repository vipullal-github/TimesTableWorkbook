package com.vipullal.flutteraps.times_table_workbook

import android.media.MediaPlayer
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMethodCodec

class MainActivity : FlutterActivity(), MethodChannel.MethodCallHandler {
    val TAG = "MainActivity"

    var m_MediaPlayer: MediaPlayer? = null

    // -----------------------------------------------------------
    // MediaPlayer.OnCompletionListener m_OnPlayCompleteListener = new
    // MediaPlayer.OnCompletionListener()
    // {
    // 	@Override
    // 	public void onCompletion(MediaPlayer mp)
    // 	{
    // 		stopSound();
    // 		m_Controller.onMediaPlayFinish();
    // 	}
    // };

    // -----------------------------------------------------------
    fun stopSound() {
        if (m_MediaPlayer != null) {
            m_MediaPlayer?.stop()
            m_MediaPlayer?.release()
            m_MediaPlayer = null
        }
    }

    // -----------------------------------------------------------
    fun startSound(inResId: Int) {
        stopSound()
        m_MediaPlayer = MediaPlayer.create(this, inResId)
        // m_MediaPlayer.setVolume(((float)m_PlaybackVolume)/100.0f,
        // ((float)m_PlaybackVolume)/100.0f);
        // m_MediaPlayer.setOnCompletionListener(m_OnPlayCompleteListener);
        m_MediaPlayer?.start()
    }

    fun playErrorSound() {
        Log.d(TAG, "Playing error sound...")
        startSound(R.raw.error)
    }

    fun playSuccessSound() {
        Log.d(TAG, "Playing success sound...")
        startSound(R.raw.rimshot)
    }

    @Override
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        Log.d(
                TAG,
                "MainActivity::configureFlutterEngine called on " +
                        Thread.currentThread().toString()
        )

        val bm: BinaryMessenger = flutterEngine.dartExecutor.binaryMessenger
        // NB: I suspect that the TaskQueue is only used to send a stream of events to the dart
        // side.
        //        val tq:BinaryMessenger.TaskQueue = bm.makeBackgroundTaskQueue();
        //        val mc = MethodChannel(bm, "methodChannelDemo", StandardMethodCodec.INSTANCE, tq
        // );
        val mc = MethodChannel(bm, "audioPlayerChannel", StandardMethodCodec.INSTANCE)
        mc.setMethodCallHandler(this)
    }

    // ------------------------------------------------------------------------
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "playError" -> playErrorSound()
            "playSuccess" -> playSuccessSound()
            else -> result.notImplemented()
        }
        result.success(0)
    }
}
