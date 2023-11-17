package com.example.test;

import androidx.appcompat.app.AppCompatActivity;

import android.content.ContentValues;
import android.content.Intent;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.view.View;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.TableLayout;
import android.widget.TextView;
import android.widget.Toast;

public class VerParcela extends AppCompatActivity {

    private EditText descripcion;
    private CheckBox CampoCubierto;
    private String id;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_ver_parcela);
        SQLiteDatabase db = MainActivity.conn.getReadableDatabase();
        Intent myIntent = getIntent();
        this.id = myIntent.getStringExtra("id");
        String[] parametros = {this.id};
        Cursor cursor = db.rawQuery("SELECT * FROM parcelas WHERE id = ?", parametros);
        cursor.moveToFirst();
        this.descripcion = (EditText) findViewById(R.id.campoDescripcion);
        this.descripcion.setText(cursor.getString(1));
        TextView titulo = (TextView) findViewById(R.id.idTitulo);
        titulo.setText(cursor.getString(0));
        this.CampoCubierto = (CheckBox) findViewById(R.id.checkBox);
        if (cursor.getString(2).equals("Si")) {
            this.CampoCubierto.setChecked(true);
        } else {
            this.CampoCubierto.setChecked(false);
        }
    }

    public void guardar(View view) {
        actualizarParcela();
    }

    public void actualizarParcela() {
        SQLiteDatabase db = MainActivity.conn.getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put("descripcion", this.descripcion.getText().toString());
        if (this.CampoCubierto.isChecked()){
            values.put("cubierta", "Si");
        } else {
            values.put("cubierta", "No");
        }

        String[] parametros = {this.id};
        db.update("parcelas",values,"id =?",parametros);

        Toast.makeText(getApplicationContext(), "Se actualizo la parcela",Toast.LENGTH_SHORT).show();
        db.close();

        Intent intent = new Intent(this, Parcelas.class);
        startActivity(intent);
    }

    public void eliminar(View view) {
        eliminarParcela();
    }

    private void eliminarParcela() {
        SQLiteDatabase db = MainActivity.conn.getReadableDatabase();
        String[] parametros = {this.id};
        Cursor cursor = db.rawQuery("SELECT * FROM quintas_parcelas WHERE idParcela =?", parametros);
        cursor.moveToFirst();
        if (cursor.getCount() == 0) {
            db = MainActivity.conn.getWritableDatabase();

            db.delete("parcelas","id =?",parametros);

            Toast.makeText(getApplicationContext(), "Se elimino la parcela",Toast.LENGTH_SHORT).show();

            Intent intent = new Intent(this, Parcelas.class);
            startActivity(intent);
        } else {
            Toast.makeText(getApplicationContext(), "Error: Pertenece a una quinta",Toast.LENGTH_SHORT).show();
        }
        db.close();
    }
}