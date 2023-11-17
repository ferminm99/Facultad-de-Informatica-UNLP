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

public class VerBolson extends AppCompatActivity {

    private Map<String,Integer> cantVerduras = new HashMap<String,Integer>();
    private Map<String,Integer> cantVerdurasInsert = new HashMap<String,Integer>();
    private EditText vigencia;
    private EditText cantidadBolsones;
    private String id;
    private String idQuinta;
    private String mes;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_ver_bolson);
        SQLiteDatabase db = MainActivity.conn.getReadableDatabase();
        Intent myIntent = getIntent();
        this.id = myIntent.getStringExtra("id");
        String[] parametros = {this.id};
        Cursor cursor = db.rawQuery("SELECT * FROM bolsones WHERE id = ?", parametros);
        cursor.moveToFirst();
        this.vigencia = (EditText) findViewById(R.id.editTextNumber4);
        this.vigencia.setText(cursor.getString(2));
        this.cantidadBolsones = (EditText) findViewById(R.id.editTextNumber8);
        this.cantidadBolsones.setText(cursor.getString(3));
        this.idQuinta = cursor.getString(1);
        String[] parametros1 = {this.idQuinta};
        Cursor rowQuinta = db.rawQuery("SELECT * FROM quintas WHERE id = ?", parametros1);
        rowQuinta.moveToFirst();
        ArrayList<String> opcionQuinta = new ArrayList<String>();
        opcionQuinta.add(rowQuinta.getString(1));
        Spinner quinta = (Spinner) findViewById(R.id.siembra3);
        ArrayAdapter<String> spinnerAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, opcionQuinta);
        quinta.setAdapter(spinnerAdapter);
        findViewById(R.id.siembra3).setEnabled(false);
        ArrayList<String> opcionMes = new ArrayList<String>();
        this.mes = cursor.getString(4);
        opcionMes.add(this.mes);
        Spinner mes = (Spinner) findViewById(R.id.siembra2);
        ArrayAdapter<String> spinnerAdapter2 = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, opcionMes);
        mes.setAdapter(spinnerAdapter2);
        findViewById(R.id.siembra2).setEnabled(false);

        cargarVerdurasEnMap();
    }

    public void cargarVerdurasEnMap() {
        SQLiteDatabase db = MainActivity.conn.getReadableDatabase();
        Cursor rowVerduras = db.rawQuery("SELECT idVerdura, cantidadSurcos FROM quintas_parcelas WHERE idQuinta='"+this.idQuinta+"'", null);
        while (rowVerduras.moveToNext()) {
            String idVerdura = rowVerduras.getString(0);
            Cursor verdura = db.rawQuery("SELECT * FROM verduras WHERE id='"+idVerdura+"' AND cosecha='"+this.mes+"'", null);
            verdura.moveToFirst();
            if (verdura.getCount() != 0) {
                this.cantVerduras.put(verdura.getString(1), this.cantVerduras.getOrDefault(verdura.getString(1), 0) + Integer.parseInt(rowVerduras.getString(1)));
            }
        }
        completarTablaVerduras();
    }

    public void completarTablaVerduras() {
        SQLiteDatabase db = MainActivity.conn.getReadableDatabase();
        TableLayout tableLayout=(TableLayout)findViewById(R.id.tableLayout);
        for (String key : this.cantVerduras.keySet()) {
            View tableRow = LayoutInflater.from(this).inflate(R.layout.table_item_verdura_bolson,null,false);
            TextView name  = (TextView) tableRow.findViewById(R.id.name);
            name.setText(key);
            tableLayout.addView(tableRow);

            EditText inputCant = (EditText) tableRow.findViewById(R.id.inputCant);
            inputCant.setTag(key);
            Cursor rowVerduraCantidad = db.rawQuery("SELECT cantidad FROM bolsones_verduras WHERE nombre='"+key+"' AND idBolson='"+this.id+"'", null);
            rowVerduraCantidad.moveToFirst();
            if (rowVerduraCantidad.getCount() != 0) {
                inputCant.setText(rowVerduraCantidad.getString(0));
            } else {
                inputCant.setText("0");
            }
        }
    }

    public void eliminar(View view) {
        eliminarBolson();
    }

    private void eliminarBolson() {
        SQLiteDatabase db = MainActivity.conn.getWritableDatabase();
        String[] parametros = {this.id};
        db.delete("bolsones","id =?",parametros);
        db.delete("bolsones_verduras", "idBolson=?", parametros);
        Toast.makeText(getApplicationContext(), "Se elimino el bolson",Toast.LENGTH_SHORT).show();

        Intent intent = new Intent(this, Bolsones.class);
        startActivity(intent);

        db.close();
    }

    public void guardar(View view) {
        actualizarBolson();
    }

    public void actualizarBolson() {
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
            values.put("vigencia", this.vigencia.getText().toString());
            values.put("cantidad", this.cantidadBolsones.getText().toString());
            String[] parametros = {this.id};
            db.update("bolsones",values,"id =?",parametros);

            values = new ContentValues();
            db.delete("bolsones_verduras", "idBolson=?", parametros);
            for (String key : this.cantVerdurasInsert.keySet()) {
                Integer cantidad = this.cantVerdurasInsert.get(key);
                values.put("cantidad", cantidad);
                values.put("nombre", key);
                values.put("idBolson", this.id);
                Long idBolsones_Verduras = db.insert("bolsones_verduras", null, values);
            }
            Toast.makeText(getApplicationContext(), "Se actualizo el bolson",Toast.LENGTH_SHORT).show();

            Intent intent = new Intent(this, Bolsones.class);
            startActivity(intent);
        } else {
            Toast.makeText(getApplicationContext(), "No hay suficientes verduras",Toast.LENGTH_SHORT).show();
        }
    }
}