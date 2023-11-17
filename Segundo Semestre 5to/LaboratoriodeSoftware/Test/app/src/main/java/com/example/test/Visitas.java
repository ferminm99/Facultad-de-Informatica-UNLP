package com.example.test;

import androidx.appcompat.app.AppCompatActivity;

import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TableLayout;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;

public class Visitas extends AppCompatActivity {

    private int pagina = 1;
    private double paginasTotales = 1;
    private ArrayList<String> meses = new ArrayList<String>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_visitas);

        EditText tv_filter = (EditText) findViewById(R.id.editTextTextPersonName4);

        TextWatcher fieldValidatorTextWatcher = new TextWatcher() {
            @Override
            public void afterTextChanged(Editable s) {
            }

            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {
            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                consultarVisitas();
            }
        };
        tv_filter.addTextChangedListener(fieldValidatorTextWatcher);

        this.meses.add("Seleccione...");
        this.meses.add("Enero");
        this.meses.add("Febrero");
        this.meses.add("Marzo");
        this.meses.add("Abril");
        this.meses.add("Mayo");
        this.meses.add("Junio");
        this.meses.add("Julio");
        this.meses.add("Agosto");
        this.meses.add("Septiembre");
        this.meses.add("Octubre");
        this.meses.add("Noviembre");
        this.meses.add("Diciembre");
        Spinner spinner = (Spinner) findViewById(R.id.spinner);
        ArrayAdapter<String> spinnerAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, this.meses);
        spinner.setAdapter(spinnerAdapter);
        spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
               consultarVisitas();
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });

        consultarVisitas();

    }

    private void consultarVisitas() {
        SQLiteDatabase db = MainActivity.conn.getReadableDatabase();
        Spinner select = (Spinner) findViewById(R.id.spinner);
        String mes = select.getSelectedItem().toString();
        EditText s = (EditText) findViewById(R.id.editTextTextPersonName4);
        Cursor rowQuintas;
        Cursor rowCantidad;
        if (mes.equals("Seleccione...")) {
            rowCantidad = db.rawQuery("SELECT count(*) FROM quintas INNER JOIN visitas ON(quintas.id=visitas.idQuinta) WHERE quintas.nombre LIKE '%"+s.getText().toString()+"%'", null);
            rowQuintas = db.rawQuery("SELECT quintas.nombre, quintas.id, visitas.tecnico, visitas.mes FROM quintas INNER JOIN visitas ON(quintas.id=visitas.idQuinta) WHERE quintas.nombre LIKE '%"+s.getText().toString()+"%' LIMIT 12 OFFSET "+(pagina - 1)*12, null);
        } else {
            rowCantidad = db.rawQuery("SELECT count(*) FROM quintas INNER JOIN visitas ON(quintas.id=visitas.idQuinta) WHERE quintas.nombre LIKE '%"+s.getText().toString()+"%' AND visitas.mes='"+mes+"'", null);
            rowQuintas = db.rawQuery("SELECT quintas.nombre, quintas.id, visitas.tecnico, visitas.mes FROM quintas INNER JOIN visitas ON(quintas.id=visitas.idQuinta) WHERE quintas.nombre LIKE '%"+s.getText().toString()+"%' AND visitas.mes='"+mes+"' LIMIT 12 OFFSET "+(pagina - 1)*12, null);
        }
        rowCantidad.moveToFirst();
        setPaginasTotales(rowCantidad.getInt(0));
        setTabla(rowQuintas);
    }

    private void setTabla(Cursor data) {
        cleanTable();
        SQLiteDatabase db = MainActivity.conn.getReadableDatabase();
        TableLayout tableLayout=(TableLayout)findViewById(R.id.tableLayout);
        while (data.moveToNext()) {
            View tableRow = LayoutInflater.from(this).inflate(R.layout.table_item,null,false);
            TextView name  = (TextView) tableRow.findViewById(R.id.name);
            TextView title  = (TextView) tableRow.findViewById(R.id.title);

            String idQuinta = data.getString(1);
            Cursor rowQuinta = db.rawQuery("SELECT nombre FROM quintas WHERE id='"+idQuinta+"'", null);
            rowQuinta.moveToFirst();
            name.setText(rowQuinta.getString(0));
            title.setText(data.getString(3));
            tableLayout.addView(tableRow);

            String id = data.getString(0);
            tableRow.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    goToVerVisita(id);
                }
            });

        }
    }

    public void goToVerVisita(String id) {
        Intent intent = new Intent(this, VerVisita.class);
        intent.putExtra("id",id);
        startActivity(intent);
    }

    /** Called when the user taps the Send button */
    public void goToCrearVisita(View view) {
        Intent intent = new Intent(this, CrearVisita.class);
        startActivity(intent);
    }

    public void siguiente(View view) {
        if (this.pagina < this.paginasTotales) {
            this.pagina++;
            cleanTable();
            consultarVisitas();
        } else {
            Toast.makeText(getApplicationContext(), "No hay mas elementos",Toast.LENGTH_SHORT).show();
        }
    }

    public void anterior(View view) {
        if (this.pagina > 1) {
            this.pagina--;
            cleanTable();
            consultarVisitas();
        } else {
            Toast.makeText(getApplicationContext(), "No hay mas elementos",Toast.LENGTH_SHORT).show();
        }
    }

    private void cleanTable() {
        TableLayout table = (TableLayout)findViewById(R.id.tableLayout);

        int childCount = table.getChildCount();

        if (childCount > 1) {
            table.removeViews(1, childCount - 1);
        }
    }

    private void setPaginasTotales(int cantidad) {
        this.paginasTotales = Math.ceil(((double) cantidad / (double) 12));
    }
}