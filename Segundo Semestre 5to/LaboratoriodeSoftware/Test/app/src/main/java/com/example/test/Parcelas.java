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

public class Parcelas extends AppCompatActivity {

    private int pagina = 1;
    private double paginasTotales = 1;
    private ArrayList<String> estados = new ArrayList<String>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_parcelas);

        this.estados.add("Seleccione...");
        this.estados.add("Si");
        this.estados.add("No");

        EditText tv_filter = (EditText) findViewById(R.id.editTextTextPersonName9);

        TextWatcher fieldValidatorTextWatcher = new TextWatcher() {
            @Override
            public void afterTextChanged(Editable s) {
            }

            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {
            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                consultarParcelas();
            }
        };
        tv_filter.addTextChangedListener(fieldValidatorTextWatcher);

        Spinner spinner = (Spinner) findViewById(R.id.spinner6);
        ArrayAdapter<String> spinnerAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, this.estados);
        spinner.setAdapter(spinnerAdapter);
        spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                consultarParcelas();
            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        });

        consultarParcelas();
    }

    private void consultarParcelas() {
        SQLiteDatabase db = MainActivity.conn.getReadableDatabase();
        Spinner select = (Spinner) findViewById(R.id.spinner6);
        String estado = select.getSelectedItem().toString();
        EditText s = (EditText) findViewById(R.id.editTextTextPersonName9);
        Cursor rowParcelas;
        Cursor rowCantidad;
        if (estado.equals("Seleccione...")) {
            rowCantidad = db.rawQuery("SELECT count(*) as paginas FROM parcelas WHERE descripcion LIKE '%"+s.getText().toString()+"%'", null);
            rowParcelas = db.rawQuery("SELECT * FROM parcelas WHERE descripcion LIKE '%"+s.getText().toString()+"%' LIMIT 12 OFFSET "+(pagina - 1)*12, null);
        } else {
            rowCantidad = db.rawQuery("SELECT count(*) as paginas FROM parcelas WHERE descripcion LIKE '%"+s.getText().toString()+"%' AND cubierta='"+estado+"'", null);
            rowParcelas = db.rawQuery("SELECT * FROM parcelas WHERE descripcion LIKE '%"+s.getText().toString()+"%' AND cubierta='"+estado+"' LIMIT 12 OFFSET "+(pagina - 1)*12, null);
        }
        rowCantidad.moveToFirst();
        setPaginasTotales(rowCantidad.getInt(0));
        setTabla(rowParcelas);
    }

    private void setTabla(Cursor data) {
        cleanTable();
        TableLayout tableLayout=(TableLayout)findViewById(R.id.tableLayout);
        while (data.moveToNext()) {
            View tableRow = LayoutInflater.from(this).inflate(R.layout.table_item,null,false);
            TextView name  = (TextView) tableRow.findViewById(R.id.name);
            TextView title  = (TextView) tableRow.findViewById(R.id.title);


            name.setText(data.getString(1));
            title.setText(data.getString(2));
            tableLayout.addView(tableRow);

            String id = data.getString(0);
            tableRow.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    goToVerParcela(id);
                }
            });

        }
    }

    public void goToVerParcela(String id) {
        Intent intent = new Intent(this, VerParcela.class);
        intent.putExtra("id",id);
        startActivity(intent);
    }

    /** Called when the user taps the Send button */
    public void goToCrearParcela(View view) {
        Intent intent = new Intent(this, CrearParcela.class);
        startActivity(intent);
    }

    public void siguiente(View view) {
        if (this.pagina < this.paginasTotales) {
            this.pagina++;
            cleanTable();
            consultarParcelas();
        } else {
            Toast.makeText(getApplicationContext(), "No hay mas elementos",Toast.LENGTH_SHORT).show();
        }
    }

    public void anterior(View view) {
        if (this.pagina > 1) {
            this.pagina--;
            cleanTable();
            consultarParcelas();
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