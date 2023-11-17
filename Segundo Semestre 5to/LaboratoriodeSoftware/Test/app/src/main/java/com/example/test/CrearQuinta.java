package com.example.test;

import androidx.appcompat.app.AppCompatActivity;
import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TableLayout;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.HashMap;

import org.osmdroid.views.MapController;
import org.osmdroid.views.MapView;

public class CrearQuinta extends AppCompatActivity {

    private EditText CampoNombre;
    private EditText CampoDireccion;
    private EditText CampoSuperficie;
    private EditText CampoLatitud;
    private EditText CampoLongitud;
    private HashMap datos;
    private HashMap datosQuinta;
    private MapView mMapView;
    private MapController mMapController;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_crear_quinta);

        this.CampoNombre = (EditText) findViewById(R.id.editTextTextPersonName);
        this.CampoDireccion = (EditText) findViewById(R.id.editTextTextPersonName2);
        this.CampoSuperficie = (EditText) findViewById(R.id.editTextNumber);
        this.CampoLatitud = (EditText) findViewById(R.id.editTextNumber2);
        this.CampoLongitud = (EditText) findViewById(R.id.editTextNumber6);
        this.CampoLongitud.setEnabled(false);
        this.CampoLatitud.setEnabled(false);

        Intent intent = getIntent();

        if ((HashMap) intent.getSerializableExtra("datos") != null) {
            this.datos = (HashMap) intent.getSerializableExtra("datos");
            this.datosQuinta = (HashMap) this.datos.get("quinta");
            this.CampoNombre.setText(this.datosQuinta.get("nombre").toString());
            this.CampoDireccion.setText(this.datosQuinta.get("direccion").toString());
            this.CampoSuperficie.setText(this.datosQuinta.get("superficie").toString());
            this.CampoLatitud.setText(this.datosQuinta.get("latitud").toString());
            this.CampoLongitud.setText(this.datosQuinta.get("longitud").toString());

            SQLiteDatabase db = MainActivity.conn.getReadableDatabase();
            TableLayout tableLayout=(TableLayout)findViewById(R.id.tableLayout);
            for (Object id: this.datos.keySet()) {
                if (!id.toString().equals("quinta")) {
                    Cursor data = db.rawQuery("SELECT descripcion FROM parcelas WHERE id="+id.toString(), null);
                    data.moveToFirst();
                    View tableRow = LayoutInflater.from(this).inflate(R.layout.table_item_parcela_quinta,null,false);
                    TextView name  = (TextView) tableRow.findViewById(R.id.name);
                    name.setText(data.getString(0));
                    tableLayout.addView(tableRow);
                }
            }

        } else {
            this.datos = new HashMap();
            this.datosQuinta = new HashMap();
        }
    }

    public void onClick(View view) {
        registrarQuinta();
    }

    private void registrarQuinta() {
        SQLiteDatabase db = MainActivity.conn.getWritableDatabase();

        ContentValues values = new ContentValues();
        values.put("nombre", this.CampoNombre.getText().toString());
        values.put("direccion", this.CampoDireccion.getText().toString());
        values.put("superficie", this.CampoSuperficie.getText().toString());
        values.put("latitud", this.CampoLatitud.getText().toString());
        values.put("longitud", this.CampoLongitud.getText().toString());

        Long idResultante = db.insert("quintas", null, values);

        for (Object parcela: this.datos.keySet()) {
            if (!parcela.toString().equals("quinta")) {
                values = new ContentValues();
                values.put("idQuinta", idResultante);
                values.put("idParcela", parcela.toString());
                ArrayList verduras = (ArrayList) this.datos.get(parcela.toString());
                for (int i = 0; i < verduras.size()-2; i++) {
                    values.put("idVerdura", verduras.get(i).toString());
                    values.put("cantidadSurcos", verduras.get(verduras.size()-2).toString());
                    values.put("superficieParcela", verduras.get(verduras.size()-1).toString());
                    db.insert("quintas_parcelas", null, values);
                }
            }
        }

        Toast.makeText(getApplicationContext(), "Id Registro: "+idResultante,Toast.LENGTH_SHORT).show();

        Intent intent = new Intent(this, Quintas.class);
        startActivity(intent);

    }

    public void agregarParcela(View view) {
        Intent intent = new Intent(this, ParcelasParaAgregar.class);
        this.datosQuinta.put("nombre", this.CampoNombre.getText());
        this.datosQuinta.put("direccion", this.CampoDireccion.getText());
        this.datosQuinta.put("superficie", this.CampoSuperficie.getText());
        this.datosQuinta.put("latitud", this.CampoLatitud.getText());
        this.datosQuinta.put("longitud", this.CampoLongitud.getText());
        this.datos.put("quinta", this.datosQuinta);
        intent.putExtra("datos", this.datos);
        intent.putExtra("activity","crear");
        startActivity(intent);
    }

    public void verMapa(View view) {
        Intent intent = new Intent(this, MapActivity.class);
        this.datosQuinta.put("nombre", this.CampoNombre.getText());
        this.datosQuinta.put("direccion", this.CampoDireccion.getText());
        this.datosQuinta.put("superficie", this.CampoSuperficie.getText());
        this.datosQuinta.put("latitud", this.CampoLatitud.getText());
        this.datosQuinta.put("longitud", this.CampoLongitud.getText());
        this.datos.put("quinta", this.datosQuinta);
        intent.putExtra("datos", this.datos);
        intent.putExtra("activity","crear");
        startActivity(intent);
    }

}