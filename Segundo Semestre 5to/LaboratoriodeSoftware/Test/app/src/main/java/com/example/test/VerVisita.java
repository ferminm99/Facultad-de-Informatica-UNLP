package com.example.test;

import androidx.appcompat.app.AppCompatActivity;
import androidx.constraintlayout.widget.ConstraintLayout;

import android.content.ContentValues;
import android.content.Intent;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class VerVisita extends AppCompatActivity {

    static public Map<String,String> cantVerduras = new HashMap<String,String>();
    private Map<String,String> cantVerdurasInsert = new HashMap<String,String>();
    private ArrayList<String> quintas = new ArrayList<>();
    private String idQuinta;
    private EditText nombre;
    private Spinner mesVisita;
    private String id;
    private String mes;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_ver_visita);

        SQLiteDatabase db = MainActivity.conn.getReadableDatabase();
        Intent myIntent = getIntent();
        this.id = myIntent.getStringExtra("id");
        String[] parametros = {this.id};
        Cursor cursor = db.rawQuery("SELECT * FROM visitas WHERE id = ?", parametros);
        cursor.moveToFirst();
        this.nombre = (EditText) findViewById(R.id.editTextTextPersonName3);
        this.nombre.setText(cursor.getString(2));
        this.idQuinta = cursor.getString(1);
        String[] parametros1 = {this.idQuinta};
        Cursor rowQuinta = db.rawQuery("SELECT * FROM quintas WHERE id = ?", parametros1);
        rowQuinta.moveToFirst();
        ArrayList<String> opcionQuinta = new ArrayList<String>();
        opcionQuinta.add(rowQuinta.getString(1));
        Spinner quinta = (Spinner) findViewById(R.id.siembra4);
        ArrayAdapter<String> spinnerAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, opcionQuinta);
        quinta.setAdapter(spinnerAdapter);
        findViewById(R.id.siembra4).setEnabled(false);
        ArrayList<String> opcionMes = new ArrayList<String>();
        this.mes = cursor.getString(3);
        opcionMes.add(this.mes);
        Spinner mes = (Spinner) findViewById(R.id.siembra5);
        ArrayAdapter<String> spinnerAdapter2 = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, opcionMes);
        mes.setAdapter(spinnerAdapter2);
        findViewById(R.id.siembra5).setEnabled(false);

        cargarVerdurasEnMap();
    }

    public void cargarVerdurasEnMap() {
        SQLiteDatabase db = MainActivity.conn.getReadableDatabase();
        Cursor rowVerduras = db.rawQuery("SELECT verdura, enCosecha FROM registro WHERE idVisita='"+this.id+"'", null);
        while (rowVerduras.moveToNext()) {
            this.cantVerduras.put(rowVerduras.getString(0), rowVerduras.getString(1));
        }
        completarTablaVerduras();
    }

    public void completarTablaVerduras() {
        TableLayout tableLayout=(TableLayout)findViewById(R.id.tableLayout);
        for (String key : this.cantVerduras.keySet()) {
            View tableRow = LayoutInflater.from(this).inflate(R.layout.table_item_visita,null,false);
            TextView name  = (TextView) tableRow.findViewById(R.id.name);
            name.setText(key);
            tableLayout.addView(tableRow);

            CheckBox checkbox = (CheckBox) tableRow.findViewById(R.id.checkboxCosecha);
            checkbox.setTag(key);
            if (this.cantVerduras.get(key).equals("SI")) {
                checkbox.setChecked(true);
            }
        }
    }

    //public void eliminarVisita(View view) {
    //    eliminarVisita();
    //}

    public void eliminarVisita(View view) {
        SQLiteDatabase db = MainActivity.conn.getWritableDatabase();
        String[] parametros = {this.id};
        db.delete("visitas","id =?",parametros);
        db.delete("registro", "idVisita=?", parametros);
        Toast.makeText(getApplicationContext(), "Se elimino la visita",Toast.LENGTH_SHORT).show();

        Intent intent = new Intent(this, Visitas.class);
        startActivity(intent);

        db.close();
    }

    //public void guardarVisita(View view) {
     //   actualizarVisita();
    //}

    public void actualizarVisita(View view) {
        SQLiteDatabase db = MainActivity.conn.getWritableDatabase();
        TableLayout tableLayout=(TableLayout)findViewById(R.id.tableLayout);
        this.cantVerdurasInsert.clear();
        for(int i = 0; i < tableLayout.getChildCount(); i++) {
            if (tableLayout.getChildAt(i) instanceof ConstraintLayout) {
                TableRow row = (TableRow) ((ConstraintLayout) tableLayout.getChildAt(i)).getChildAt(0);
                CheckBox checkBox = (CheckBox) row.getChildAt(1);
                TextView nombreVerdura = (TextView) row.getChildAt(0);
                if (checkBox.isChecked()) {
                    this.cantVerdurasInsert.put(nombreVerdura.getText().toString(), "SI");
                } else {
                    this.cantVerdurasInsert.put(nombreVerdura.getText().toString(), "NO");
                }
            }
        }

        ContentValues values = new ContentValues();
        values.put("tecnico", this.nombre.getText().toString());
        String[] parametros = {this.id};
        db.update("visitas",values,"id =?",parametros);

        values = new ContentValues();
        db.delete("registro", "idVisita=?", parametros);
        for (String key : this.cantVerdurasInsert.keySet()) {
            values.put("verdura", key);
            values.put("enCosecha", this.cantVerdurasInsert.get(key));
            values.put("idVisita", this.id);
            Long idRegistro = db.insert("registro", null, values);
        }
        Toast.makeText(getApplicationContext(), "Se actualizo la visita",Toast.LENGTH_SHORT).show();

        Intent intent = new Intent(this, Visitas.class);
        startActivity(intent);

    }
}