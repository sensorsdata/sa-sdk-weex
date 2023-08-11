package com.weex.app;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;

public class BeforeActivity extends Activity {
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.before_layout);
        findViewById(R.id.go_weex).setOnClickListener((v -> {
            startActivity(new Intent(this, WXPageActivity.class));
        }));
    }
}
