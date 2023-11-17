package com.example.test;

import androidx.appcompat.app.AppCompatActivity;

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
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TableLayout;
import android.widget.TextView;
import android.widget.Toast;

import java.util.ArrayList;

public class Verduras extends AppCompatActivity {

    private int pagina = 1;
    private double paginasTotales = 1;
    private ArrayList<String> cosechaMeses = new ArrayList<String>();
    private ArrayList<String> siembraMeses = new ArrayList<String>();
    private ArrayList<String> meses = new ArrayList<String>();
    private Spinner siembraSpinner;
    private Spinner cosechaSpinner;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_verduras);

        EditText tv_filter = (EditText) findViewById(R.id.editTextTextPersonName6);

        TextWatcher fieldValidatorTextWatcher = new TextWatcher() {
            @Override
            public void afterTextChanged(Editable s) {
            }

            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {
            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                consultarVerduras();
            }
        };
        tv_filter.addTextChangedListener(fieldValidatorTextWatcher);

        this.cosechaMeses.add("Mes de cosecha");
        this.siembraMeses.add("Mes de siembra");
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
        this.cosechaMeses.addAll(meses);
        this.siembraMeses.addAll(meses);

        this.siembraSpinner = (Spinner) findViewById(R.id.spinner4);
        ArrayAdapter<String> spinnerAdapter = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, this.siembraMeses);
        this.siembraSpinner.setAdapter(spinnerAdapter);
        this.cosechaSpinner = (Spinner) findViewById(R.id.spinner5);
        ArrayAdapter<String> spinnerAdapter2 = new ArrayAdapter<String>(this, android.R.layout.simple_spinner_item, this.cosechaMeses);
        this.cosechaSpinner.setAdapter(spinnerAdapter2);

        AdapterView.OnItemSelectedListener listener = new AdapterView.OnItemSelectedListener() {
            @Override
            public void onItemSelected(AdapterView<?> parent, View view, int position, long id) {
                consultarVerduras();

            }

            @Override
            public void onNothingSelected(AdapterView<?> parent) {

            }
        };

        this.siembraSpinner.setOnItemSelectedListener(listener);
        this.cosechaSpinner.setOnItemSelectedListener(listener);

        consultarVerduras();
    }

    private void consultarVerduras() {
        SQLiteDatabase db = MainActivity.conn.getReadableDatabase();
        EditText s = (EditText) findViewById(R.id.editTextTextPersonName6);
        Spinner select = (Spinner) findViewById(R.id.spinner4);
        Spinner select2 = (Spinner) findViewById(R.id.spinner5);
        String siembra = select.getSelectedItem().toString();
        String cosecha = select2.getSelectedItem().toString();
        Cursor rowVerduras;
        Cursor rowCantidad;
        if (siembra.equals("Mes de siembra") && cosecha.equals("Mes de cosecha")) { //NO ELIGIO NADA
            rowCantidad = db.rawQuery("SELECT count(*) FROM verduras WHERE descripcion LIKE '%" + s.getText().toString() + "%'", null);
            rowVerduras = db.rawQuery("SELECT * FROM verduras WHERE descripcion LIKE '%" + s.getText().toString() + "%' LIMIT 12 OFFSET " + (pagina - 1) * 12, null);
        } else if (siembra.equals("Mes de siembra")) { //ELIGIO COSECHA
            rowCantidad = db.rawQuery("SELECT count(*) FROM verduras WHERE descripcion LIKE '%" + s.getText().toString() + "%' AND cosecha='" + cosecha + "'", null);
            rowVerduras = db.rawQuery("SELECT * FROM verduras WHERE descripcion LIKE '%" + s.getText().toString() + "%' AND cosecha='" + cosecha + "' LIMIT 12 OFFSET " + (pagina - 1) * 12, null);
        } else if (cosecha.equals("Mes de cosecha")) { //ELIGIO SIEMBRA
            rowCantidad = db.rawQuery("SELECT count(*) FROM verduras WHERE descripcion LIKE '%" + s.getText().toString() + "%' AND siembra='" + siembra + "'", null);
            rowVerduras = db.rawQuery("SELECT * FROM verduras WHERE descripcion LIKE '%" + s.getText().toString() + "%' AND siembra='" + siembra + "' LIMIT 12 OFFSET " + (pagina - 1) * 12, null);
        } else { //ELIGIO AMBOS
            rowCantidad = db.rawQuery("SELECT count(*) FROM verduras WHERE descripcion LIKE '%" + s.getText().toString() + "%' AND siembra='" + siembra + "' AND cosecha='" + cosecha + "'" , null);
            rowVerduras = db.rawQuery("SELECT * FROM verduras WHERE descripcion LIKE '%" + s.getText().toString() + "%' AND siembra='" + siembra + "' AND cosecha='" + cosecha + "' LIMIT 12 OFFSET " + (pagina - 1) * 12, null);
        }
        rowCantidad.moveToFirst();
        setPaginasTotales(rowCantidad.getInt(0));
        setTabla(rowVerduras);

    }

    private void setTabla(Cursor data) {
        cleanTable();
        TableLayout tableLayout=(TableLayout)findViewById(R.id.tableLayout);
        while (data.moveToNext()) {
            View tableRow = LayoutInflater.from(this).inflate(R.layout.table_item_verdura,null,false);
            TextView name  = (TextView) tableRow.findViewById(R.id.name);
            TextView siembra  = (TextView) tableRow.findViewById(R.id.siembra);
            TextView cosecha  = (TextView) tableRow.findViewById(R.id.cosecha);


            name.setText(data.getString(1));
            siembra.setText(data.getString(2));
            cosecha.setText(data.getString(3));
            tableLayout.addView(tableRow);

            String id = data.getString(0);
            tableRow.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    goToVerVerdura(id);
                }
            });

        }
    }

    public void goToVerVerdura(String id) {
        Intent intent = new Intent(this, VerVerdura.class);
        intent.putExtra("id",id);
        startActivity(intent);
    }

    /** Called when the user taps the Send button */
    public void goToCrearVerdura(View view) {
        Intent intent = new Intent(this, CrearVerdura.class);
        startActivity(intent);
    }

    public void siguiente(View view) {
        if (this.pagina < this.paginasTotales) {
            this.pagina++;
            cleanTable();
            consultarVerduras();
        } else {
            Toast.makeText(getApplicationContext(), "No hay mas elementos",Toast.LENGTH_SHORT).show();
        }
    }

    public void anterior(View view) {
        if (this.pagina > 1) {
            this.pagina--;
            cleanTable();
            consultarVerduras();
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