package com.example.test;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    static ConexionSQLiteHelper conn;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        this.conn = new ConexionSQLiteHelper(getApplicationContext(),"bd_justa",null,10);
    }

    /** Called when the user taps the Send button */
    public void goToParcelas(View view) {
        Intent intent = new Intent(this, Parcelas.class);
        startActivity(intent);
    }

    public void goToVerduras(View view) {
        Intent intent = new Intent(this, Verduras.class);
        startActivity(intent);
    }

    public void goToQuintas(View view) {
        Intent intent = new Intent(this, Quintas.class);
        startActivity(intent);
    }

    public void goToBolsones(View view) {
        Intent intent = new Intent(this, Bolsones.class);
        startActivity(intent);
    }

    public void goToVisitas(View view) {
        Intent intent = new Intent(this, Visitas.class);
        startActivity(intent);
    }

}