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

public class CrearBolson extends AppCompatActivity {

    static public Map<String,Integer> cantVerduras = new HashMap<String,Integer>();
    private Map<String,Integer> cantVerdurasInsert = new HashMap<String,Integer>();
    private ArrayList<String> quintas = new ArrayList<>();
    private String idQuinta;
    private EditText vigencia;
    private Spinner mesArmado;
    private EditText cantidadBolsones;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_crear_bolson);

        SQLiteDatabase db = MainActivity.conn.getReadableDatabase();

        this.vigencia = (EditText) findViewById(R.id.editTextNumber4);
        this.mesArmado = (Spinner) findViewById(R.id.siembra2);
        this.cantidadBolsones = (EditText) findViewById(R.id.editTextNumber8);

        Cursor data = db.rawQuery("SELECT * FROM quintas", null);
        this.quintas.add("Seleccione...");
        while (data.moveToNext()) {
            this.quintas.add(data.getString(1));
        }
        Spinner spinner = (Spinner) findViewById(R.id.siembra3);
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
        Spinner mesSpinner = (Spinner) findViewById(R.id.siembra2);
        mesSpinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                actualizarTabla(spinner.getSelectedItemPosition());
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
            CrearBolson.cantVerduras.clear();
            cleanTable();
            Spinner selectMes = (Spinner) findViewById(R.id.siembra2);
            String mes = selectMes.getSelectedItem().toString();
            while (rowVerduras.moveToNext()) {
                String idVerdura = rowVerduras.getString(0);
                Cursor verdura = db.rawQuery("SELECT * FROM verduras WHERE id='"+idVerdura+"' AND cosecha='"+mes+"'", null);
                verdura.moveToFirst();
                if (verdura.getCount() != 0) {
                    CrearBolson.cantVerduras.put(verdura.getString(1), CrearBolson.cantVerduras.getOrDefault(verdura.getString(1), 0) + Integer.parseInt(rowVerduras.getString(1)));
                }
            }
            completarTablaVerduras();
        }
    }

    public void completarTablaVerduras() {

        TableLayout tableLayout=(TableLayout)findViewById(R.id.tableLayout);
        for (String key : CrearBolson.cantVerduras.keySet()) {
            View tableRow = LayoutInflater.from(this).inflate(R.layout.table_item_verdura_bolson,null,false);
            TextView name  = (TextView) tableRow.findViewById(R.id.name);
            name.setText(key);
            tableLayout.addView(tableRow);

            EditText inputCant = (EditText) tableRow.findViewById(R.id.inputCant);
            inputCant.setTag(key);
            inputCant.setText("0");

            //CheckBox checkbox = (CheckBox) tableRow.findViewById(R.id.checkbox_meat);
            //checkbox.setTag(key);
        }
    }

    private void cleanTable() {
        TableLayout table = (TableLayout)findViewById(R.id.tableLayout);

        int childCount = table.getChildCount();

        if (childCount > 1) {
            table.removeViews(1, childCount - 1);
        }
    }

    public void onCheckboxClicked(View view) {
        //view.getTag();
        //if (this.CampoCubierto.isChecked()){
        //    values.put("cubierta", "Si");
        //} else {
         //   values.put("cubierta", "No");
        //}
    }

    public void onClick(View view) {
        registrarBolson();
    }

    private void registrarBolson() {
        SQLiteDatabase db = MainActivity.conn.getWritableDatabase();
        TableLayout tableLayout=(TableLayout)findViewById(R.id.tableLayout);
        EditText inputCantidad = (EditText) findViewById(R.id.editTextNumber8);
        boolean sePuede = true;
        this.cantVerdurasInsert.clear();
        for(int i = 0; i < tableLayout.getChildCount(); i++) {
            if (tableLayout.getChildAt(i) instanceof ConstraintLayout) {
                TableRow row = (TableRow) ((ConstraintLayout) tableLayout.getChildAt(i)).getChildAt(0);
                TextView inputTabla = (TextView) row.getChildAt(1);
                TextView nombreVerdura = (TextView) row.getChildAt(0);
                Integer cantidadPedida = Integer.parseInt(inputTabla.getText().toString()) * Integer.parseInt(inputCantidad.getText().toString());
                if (this.cantVerduras.get(nombreVerdura.getText().toString()) < cantidadPedida && cantidadPedida != 0) {
                    sePuede = false;
                } else if (cantidadPedida != 0) {
                    this.cantVerdurasInsert.put(nombreVerdura.getText().toString(), Integer.parseInt(inputTabla.getText().toString()));
                }
            }
        }

        if (sePuede) {
            ContentValues values = new ContentValues();
            values.put("idQuinta", this.idQuinta);
            values.put("vigencia", this.vigencia.getText().toString());
            values.put("mes", this.mesArmado.getSelectedItem().toString());
            values.put("cantidad", this.cantidadBolsones.getText().toString());
            Long idResultante = db.insert("bolsones", null, values);

            values = new ContentValues();
            for (String key : this.cantVerdurasInsert.keySet()) {
                Integer cantidad = this.cantVerdurasInsert.get(key);
                values.put("cantidad", cantidad);
                values.put("nombre", key);
                values.put("idBolson", idResultante);
                Long idBolsones_Verduras = db.insert("bolsones_verduras", null, values);
            }
            Toast.makeText(getApplicationContext(), "Id registro: "+idResultante,Toast.LENGTH_SHORT).show();

            Intent intent = new Intent(this, Bolsones.class);
            startActivity(intent);
        } else {
            Toast.makeText(getApplicationContext(), "No hay suficientes verduras",Toast.LENGTH_SHORT).show();
        }

    }
}