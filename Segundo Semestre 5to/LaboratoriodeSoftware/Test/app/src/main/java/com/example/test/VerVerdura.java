package com.example.test;

import androidx.appcompat.app.AppCompatActivity;

import android.content.ContentValues;
import android.content.Intent;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

public class VerVerdura extends AppCompatActivity {

    private EditText descripcion;
    private Spinner siembra;
    private Spinner cosecha;
    private String id;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_ver_verdura);
        SQLiteDatabase db = MainActivity.conn.getReadableDatabase();
        Intent myIntent = getIntent();
        this.id = myIntent.getStringExtra("id");
        String[] parametros = {this.id};
        Cursor cursor = db.rawQuery("SELECT * FROM verduras WHERE id = ?", parametros);
        cursor.moveToFirst();
        this.descripcion = (EditText) findViewById(R.id.campoDescripcion);
        this.descripcion.setText(cursor.getString(1));
        TextView titulo = (TextView) findViewById(R.id.textView20);
        titulo.setText(cursor.getString(0));
        this.siembra = (Spinner) findViewById(R.id.siembra);
        ArrayAdapter myAdap = (ArrayAdapter) this.siembra.getAdapter();
        int spinnerPosition = myAdap.getPosition(cursor.getString(2));
        this.siembra.setSelection(spinnerPosition);
        this.cosecha = (Spinner) findViewById(R.id.cosecha);
        myAdap = (ArrayAdapter) this.cosecha.getAdapter();
        spinnerPosition = myAdap.getPosition(cursor.getString(3));
        this.cosecha.setSelection(spinnerPosition);
    }

    public void guardar(View view) {
        actualizarVerdura();
    }

    public void actualizarVerdura() {
        SQLiteDatabase db = MainActivity.conn.getWritableDatabase();
        ContentValues values = new ContentValues();
        values.put("descripcion", this.descripcion.getText().toString());
        values.put("siembra", this.siembra.getSelectedItem().toString());
        values.put("cosecha", this.cosecha.getSelectedItem().toString());

        String[] parametros = {this.id};
        db.update("verduras",values,"id =?",parametros);

        Toast.makeText(getApplicationContext(), "Se actualizo la verdura",Toast.LENGTH_SHORT).show();
        db.close();

        Intent intent = new Intent(this, Verduras.class);
        startActivity(intent);
    }

    public void eliminar(View view) {
        eliminarVerdura();
    }

    private void eliminarVerdura() {
        SQLiteDatabase db = MainActivity.conn.getReadableDatabase();
        String[] parametros = {this.id};
        Cursor cursor = db.rawQuery("SELECT * FROM quintas_parcelas WHERE idVerdura =?", parametros);
        cursor.moveToFirst();
        if (cursor.getCount() == 0) {
            db = MainActivity.conn.getWritableDatabase();

            db.delete("verduras","id =?",parametros);

            Toast.makeText(getApplicationContext(), "Se elimino la verdura",Toast.LENGTH_SHORT).show();

            Intent intent = new Intent(this, Verduras.class);
            startActivity(intent);
        } else {
            Toast.makeText(getApplicationContext(), "Error: Pertenece a una parcela",Toast.LENGTH_SHORT).show();
        }
        db.close();
    }
}