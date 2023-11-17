package com.example.test;

import androidx.appcompat.app.AppCompatActivity;

import android.content.ContentValues;
import android.content.Intent;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.Toast;

public class CrearVerdura extends AppCompatActivity {

    private EditText CampoDescri;
    private Spinner CampoCosecha;
    private Spinner CampoSiembra;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_crear_verdura);

        this.CampoDescri = (EditText) findViewById(R.id.descripcion);
        this.CampoCosecha = (Spinner) findViewById(R.id.cosecha);
        this.CampoSiembra = (Spinner) findViewById(R.id.siembra);
    }

    public void onClick(View view) {
        registrarVerdura();
    }

    private void registrarVerdura() {
        //ConexionSQLiteHelper conn = new ConexionSQLiteHelper(this, "bd_justa", null, 1);

        SQLiteDatabase db = MainActivity.conn.getWritableDatabase();

        ContentValues values = new ContentValues();
        values.put("descripcion", this.CampoDescri.getText().toString());
        values.put("cosecha", this.CampoCosecha.getSelectedItem().toString());
        values.put("siembra", this.CampoSiembra.getSelectedItem().toString());

        Long idResultante = db.insert("verduras", null, values);

        Toast.makeText(getApplicationContext(), "Id Registro: "+idResultante,Toast.LENGTH_SHORT).show();

        Intent intent = new Intent(this, Verduras.class);
        startActivity(intent);

    }
}