package com.example.test;

import androidx.appcompat.app.AppCompatActivity;
import androidx.constraintlayout.widget.ConstraintLayout;

import android.content.ContentValues;
import android.content.Intent;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.SpinnerAdapter;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class CrearVisita extends AppCompatActivity {

    static public Map<String,String> cantVerduras = new HashMap<String,String>();
    private Map<String,String> cantVerdurasInsert = new HashMap<String,String>();
    private ArrayList<String> quintas = new ArrayList<>();
    private String idQuinta;
    private EditText nombre;
    private Spinner mesVisita;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_crear_visita);

        SQLiteDatabase db = MainActivity.conn.getReadableDatabase();

        this.nombre = (EditText) findViewById(R.id.editTextTextPersonName3);
        this.mesVisita = (Spinner) findViewById(R.id.siembra5);

        Cursor data = db.rawQuery("SELECT * FROM quintas", null);
        this.quintas.add("Seleccione...");
        while (data.moveToNext()) {
            this.quintas.add(data.getString(1));
        }
        Spinner spinner = (Spinner) findViewById(R.id.siembra4);
        ArrayAdapter<String> spinnerAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, this.quintas);
        spinner.setAdapter(spinnerAdapter);
        spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                actualizarTabla(position);
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });
    }

    public void actualizarTabla(int position) {
        String text = this.quintas.get(position);
        SQLiteDatabase db = MainActivity.conn.getReadableDatabase();
        if (!text.equals("Seleccione...")) {
            Cursor quintaID = db.rawQuery("SELECT id FROM quintas WHERE nombre='"+text+"'", null);
            quintaID.moveToFirst();
            this.idQuinta = quintaID.getString(0);
            Cursor rowVerduras = db.rawQuery("SELECT idVerdura, cantidadSurcos FROM quintas_parcelas WHERE idQuinta='"+this.idQuinta+"'", null);
            this.cantVerduras.clear();
            cleanTable();
            Spinner selectMes = (Spinner) findViewById(R.id.siembra5);
            while (rowVerduras.moveToNext()) {
                String idVerdura = rowVerduras.getString(0);
                Cursor verdura = db.rawQuery("SELECT * FROM verduras WHERE id='"+idVerdura+"'", null);
                verdura.moveToFirst();
                if (verdura.getCount() != 0) {
                    this.cantVerduras.put(verdura.getString(1), "NO");
                }
            }
            completarTablaVerduras();
        }
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
        }
    }

    private void cleanTable() {
        TableLayout table = (TableLayout)findViewById(R.id.tableLayout);

        int childCount = table.getChildCount();

        if (childCount > 1) {
            table.removeViews(1, childCount - 1);
        }
    }

    public void onClick(View view) {
        registrarVisita();
    }

    private void registrarVisita() {
        SQLiteDatabase db = MainActivity.conn.getWritableDatabase();
        TableLayout tableLayout=(TableLayout)findViewById(R.id.tableLayout);
        this.cantVerdurasInsert.clear();
        for(int i = 0; i < tableLayout.getChildCount(); i++) {
            if (tableLayout.getChildAt(i) instanceof ConstraintLayout) {
                TableRow row = (TableRow) ((ConstraintLayout) tableLayout.getChildAt(i)).getChildAt(0);
                CheckBox checkBox = (CheckBox) row.getChildAt(1);
                TextView nombreVerdura = (TextView) row.getChildAt(0);
                if (checkBox.isChecked()){
                    this.cantVerdurasInsert.put(nombreVerdura.getText().toString(), "SI");
                } else {
                    this.cantVerdurasInsert.put(nombreVerdura.getText().toString(), "NO");
                }

            }
        }

        ContentValues values = new ContentValues();
        values.put("idQuinta", this.idQuinta);
        values.put("tecnico", this.nombre.getText().toString());
        values.put("mes", this.mesVisita.getSelectedItem().toString());
        Long idResultante = db.insert("visitas", null, values);

        values = new ContentValues();
        for (String key : this.cantVerdurasInsert.keySet()) {
            String enCosecha = this.cantVerdurasInsert.get(key);
            values.put("enCosecha", enCosecha);
            values.put("verdura", key);
            values.put("idVisita", idResultante);
            Long idRegistro = db.insert("registro", null, values);
        }
        Toast.makeText(getApplicationContext(), "Id registro: "+idResultante,Toast.LENGTH_SHORT).show();

        Intent intent = new Intent(this, Visitas.class);
        startActivity(intent);
    }
}