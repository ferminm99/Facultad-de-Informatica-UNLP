package com.example.test;

import androidx.appcompat.app.AppCompatActivity;

import android.content.ContentValues;
import android.content.Intent;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TableLayout;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;
import java.util.HashMap;

public class VerQuinta extends AppCompatActivity {

    private String id;
    private EditText CampoNombre;
    private EditText CampoDireccion;
    private EditText CampoSuperficie;
    private EditText CampoLatitud;
    private EditText CampoLongitud;
    private HashMap datosQuinta;
    private HashMap datos;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_ver_quinta);
        SQLiteDatabase db = MainActivity.conn.getReadableDatabase();
        Intent myIntent = getIntent();
        this.id = myIntent.getStringExtra("id");
        String[] parametros = {this.id};
        Cursor cursor = db.rawQuery("SELECT * FROM quintas WHERE id = ?", parametros);
        cursor.moveToFirst();
        this.CampoNombre = (EditText) findViewById(R.id.editTextTextPersonName);
        this.CampoDireccion = (EditText) findViewById(R.id.editTextTextPersonName2);
        this.CampoSuperficie = (EditText) findViewById(R.id.editTextNumber);
        this.CampoLatitud = (EditText) findViewById(R.id.editTextNumber2);
        this.CampoLongitud = (EditText) findViewById(R.id.editTextNumber6);
        this.CampoNombre.setText(cursor.getString(1));
        this.CampoDireccion.setText(cursor.getString(2));
        this.CampoSuperficie.setText(cursor.getString(3));
        this.CampoLatitud.setText(cursor.getString(4));
        this.CampoLongitud.setText(cursor.getString(5));
        this.CampoLongitud.setEnabled(false);
        this.CampoLatitud.setEnabled(false);

        setTablaParcelas();

        Intent intent = getIntent();
        if ((HashMap) intent.getSerializableExtra("datos") != null) {
            this.datos = (HashMap) intent.getSerializableExtra("datos");
            this.datosQuinta = (HashMap) this.datos.get("quinta");
            this.CampoNombre.setText(this.datosQuinta.get("nombre").toString());
            this.CampoDireccion.setText(this.datosQuinta.get("direccion").toString());
            this.CampoSuperficie.setText(this.datosQuinta.get("superficie").toString());
            this.CampoLatitud.setText(this.datosQuinta.get("latitud").toString());
            this.CampoLongitud.setText(this.datosQuinta.get("longitud").toString());

            setTablaParcelasOfDatos();

        } else {
            this.datos = new HashMap();
            this.datosQuinta = new HashMap();
        }
    }

    private void setTablaParcelas() {
        SQLiteDatabase db = MainActivity.conn.getReadableDatabase();
        String[] parametros = {this.id};
        Cursor tablaIntermedia = db.rawQuery("SELECT * FROM quintas_parcelas WHERE idQuinta = ? GROUP BY idParcela", parametros);
        TableLayout tableLayout=(TableLayout)findViewById(R.id.tableLayout);
        while (tablaIntermedia.moveToNext()) {
            String idParcela = tablaIntermedia.getString(2);
            String[] parametrosParcelas = {idParcela};
            Cursor parcelas = db.rawQuery("SELECT descripcion FROM parcelas WHERE id = ?", parametrosParcelas);
            parcelas.moveToFirst();
            View tableRow = LayoutInflater.from(this).inflate(R.layout.table_parcela_quinta_ver,null,false);
            TextView name  = (TextView) tableRow.findViewById(R.id.name);

            name.setText(parcelas.getString(0));
            tableLayout.addView(tableRow);

            Button boton = (Button) tableRow.findViewById(R.id.button25);
            boton.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    deleteParcela(idParcela,getId());
                }
            });

            tableRow.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    goToVerVerdurasDeParcela(idParcela,getId());
                }
            });
        }
        tablaIntermedia.close();
    }

    private void setTablaParcelasOfDatos() {
        SQLiteDatabase db = MainActivity.conn.getReadableDatabase();
        TableLayout tableLayout=(TableLayout)findViewById(R.id.tableLayout);
        for (Object id: this.datos.keySet()) {
            if (!id.toString().equals("quinta")) {
                Cursor data = db.rawQuery("SELECT * FROM parcelas WHERE id="+id.toString(), null);
                data.moveToFirst();
                View tableRow = LayoutInflater.from(this).inflate(R.layout.table_parcela_quinta_ver,null,false);
                TextView name  = (TextView) tableRow.findViewById(R.id.name);
                name.setText(data.getString(1));
                tableLayout.addView(tableRow);

                String idParcela = data.getString(0);
                Button boton = (Button) tableRow.findViewById(R.id.button25);
                boton.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        deleteParcelaOfDatos(idParcela);
                    }
                });

                tableRow.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        goToVerVerdurasDeParcela(idParcela,getId());
                    }
                });
            }
        }
    }

    private void goToVerVerdurasDeParcela(String idParcela, String idQuinta) {
        Intent intent = new Intent(this, VerVerdurasDeParcela.class);
        this.datosQuinta.put("nombre", this.CampoNombre.getText());
        this.datosQuinta.put("direccion", this.CampoDireccion.getText());
        this.datosQuinta.put("superficie", this.CampoSuperficie.getText());
        this.datosQuinta.put("latitud", this.CampoLatitud.getText());
        this.datosQuinta.put("longitud", this.CampoLongitud.getText());
        this.datos.put("quinta", this.datosQuinta);
        intent.putExtra("idParcela",idParcela);
        intent.putExtra("idQuinta",idQuinta);
        intent.putExtra("datos", this.datos);
        startActivity(intent);
    }

    private void deleteParcela(String idParcela,String idQuinta) {
        SQLiteDatabase db = MainActivity.conn.getWritableDatabase();
        String[] parametros = {idParcela,idQuinta};
        db.delete("quintas_parcelas","idParcela =? AND idQuinta =?",parametros);

        Toast.makeText(getApplicationContext(), "Se elimino la parcela",Toast.LENGTH_SHORT).show();
        db.close();
        cleanTable();
        setTablaParcelas();
    }

    private void deleteParcelaOfDatos(String idParcela) {
        this.datos.remove(idParcela);
        cleanTable();
        setTablaParcelas();
        setTablaParcelasOfDatos();
    }

    private void cleanTable() {
        TableLayout table = (TableLayout)findViewById(R.id.tableLayout);

        int childCount = table.getChildCount();

        if (childCount > 1) {
            table.removeViews(1, childCount - 1);
        }
    }

    public String getId() {
        return this.id;
    }

    public void agregarParcela(View view) {
        Intent intent = new Intent(this, ParcelasParaAgregar.class);
        this.datosQuinta.put("nombre", this.CampoNombre.getText());
        this.datosQuinta.put("direccion", this.CampoDireccion.getText());
        this.datosQuinta.put("superficie", this.CampoSuperficie.getText());
        this.datosQuinta.put("latitud", this.CampoLatitud.getText());
        this.datosQuinta.put("longitud", this.CampoLongitud.getText());
        this.datos.put("quinta", this.datosQuinta);
        intent.putExtra("id",this.id);
        intent.putExtra("activity","ver");
        intent.putExtra("datos", this.datos);
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
        intent.putExtra("activity","ver");
        intent.putExtra("id",this.id);
        intent.putExtra("datos", this.datos);
        startActivity(intent);
    }

    public void actualizarQuinta(View view) {
        SQLiteDatabase db = MainActivity.conn.getWritableDatabase();
        String[] parametros = {this.id};

        ContentValues values = new ContentValues();
        values.put("nombre", this.CampoNombre.getText().toString());
        values.put("direccion", this.CampoDireccion.getText().toString());
        values.put("superficie", this.CampoSuperficie.getText().toString());
        values.put("latitud", this.CampoLatitud.getText().toString());
        values.put("longitud", this.CampoLongitud.getText().toString());

        db.update("quintas",values,"id =?",parametros);

        for (Object parcela: this.datos.keySet()) {
            if (!parcela.toString().equals("quinta")) {
                values = new ContentValues();
                values.put("idQuinta", this.id);
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

        db.close();

        Toast.makeText(getApplicationContext(), "Se actualizo la quinta",Toast.LENGTH_SHORT).show();

        Intent intent = new Intent(this, Quintas.class);
        startActivity(intent);
    }

    public void deleteQuinta(View view) {
        SQLiteDatabase db = MainActivity.conn.getWritableDatabase();
        String[] parametros = {this.id};

        db.delete("quintas","id =?",parametros);
        db.delete("quintas_parcelas", "idQuinta =?",parametros);

        Toast.makeText(getApplicationContext(), "Se elimino la quinta",Toast.LENGTH_SHORT).show();
        db.close();

        Intent intent = new Intent(this, Quintas.class);
        startActivity(intent);
    }
}