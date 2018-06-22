package com.example.rikharthu.appbardemo

import android.os.Build
import android.os.Bundle
import android.support.v7.app.AppCompatActivity
import android.view.Menu
import android.widget.Toast
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        setSupportActionBar(toolbar)
        supportActionBar!!.title = "Real title"
        supportActionBar!!.setDisplayHomeAsUpEnabled(true)
        supportActionBar!!.setDisplayShowHomeEnabled(true)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            content1.z = 8f
            content2.z = 8f
            content3.z = 8f
            content4.z = 8f
        }
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
//            content.z=5f
//        }

        content1.setOnClickListener {
            Toast.makeText(this, "Clicked content 1", Toast.LENGTH_SHORT).show()
        }
        content2.setOnClickListener {
            Toast.makeText(this, "Clicked content 2", Toast.LENGTH_SHORT).show()
        }
        content3.setOnClickListener {
            Toast.makeText(this, "Clicked content 3", Toast.LENGTH_SHORT).show()
        }
        content4.setOnClickListener {
            Toast.makeText(this, "Clicked content 4", Toast.LENGTH_SHORT).show()
        }
    }

    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        menu.add("Option 1")
        menu.add("Option 2")
        return true
    }
}
