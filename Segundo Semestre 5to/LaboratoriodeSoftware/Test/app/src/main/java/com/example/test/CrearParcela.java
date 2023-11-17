package com.example.test;

import androidx.appcompat.app.AppCompatActivity;

import android.content.ContentValues;
import android.content.Intent;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.view.View;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.RadioButton;
import android.widget.Toast;

public class CrearParcela extends AppCompatActivity {

    private EditText CampoDescri;
    private CheckBox CampoCubierto;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_crear_parcela);

        this.CampoDescri = (EditText) findViewById(R.id.descripcion);
        this.CampoCubierto = (CheckBox) findViewById(R.id.cubierto);
    }

    public void onClick(View view) {
        registrarParcela();
    }

    private void registrarParcela() {
        //ConexionSQLiteHelper conn = new ConexionSQLiteHelper(this, "bd_justa", null, 1);

        SQLiteDatabase db = MainActivity.conn.getWritableDatabase();

        ContentValues values = new ContentValues();
        values.put("descripcion", this.CampoDescri.getText().toString());
        if (this.CampoCubierto.isChecked()){
            values.put("cubierta", "Si");
        } else {
            values.put("cubierta", "No");
        }

        Long idResultante = db.insert("parcelas", null, values);

        Toast.makeText(getApplicationContext(), "Id Registro: "+idResultante,Toast.LENGTH_SHORT).show();

        Intent intent = new Intent(this, Parcelas.class);
        startActivity(intent);

    }

}