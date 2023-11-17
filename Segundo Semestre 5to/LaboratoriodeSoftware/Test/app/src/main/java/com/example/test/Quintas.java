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
import android.widget.EditText;
import android.widget.Spinner;
import android.widget.TableLayout;
import android.widget.TextView;
import android.widget.Toast;

public class Quintas extends AppCompatActivity {

    private int pagina = 1;
    private double paginasTotales = 1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_quintas);

        EditText tv_filter = (EditText) findViewById(R.id.editTextTextPersonName7);
        EditText tv_filter2 = (EditText) findViewById(R.id.editTextTextPersonName8);

        TextWatcher fieldValidatorTextWatcher = new TextWatcher() {
            @Override
            public void afterTextChanged(Editable s) {
            }

            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {
            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                consultarQuintas();
            }
        };

        tv_filter.addTextChangedListener(fieldValidatorTextWatcher);
        tv_filter2.addTextChangedListener(fieldValidatorTextWatcher);

        consultarQuintas();

    }

    private void consultarQuintas() {
        SQLiteDatabase db = MainActivity.conn.getReadableDatabase();
        EditText nombre = (EditText) findViewById(R.id.editTextTextPersonName7);
        EditText direccion = (EditText) findViewById(R.id.editTextTextPersonName8);
        Cursor rowCantidad = db.rawQuery("SELECT count(*) FROM quintas WHERE nombre LIKE '%"+nombre.getText().toString()+"%' AND direccion LIKE '%"+direccion.getText().toString()+"%'", null);
        Cursor rowQuintas = db.rawQuery("SELECT * FROM quintas WHERE nombre LIKE '%"+nombre.getText().toString()+"%' AND direccion LIKE '%"+direccion.getText().toString()+"%' LIMIT 12 OFFSET "+(pagina - 1)*12, null);
        rowCantidad.moveToFirst();
        setPaginasTotales(rowCantidad.getInt(0));
        setTabla(rowQuintas);
    }

    private void setTabla(Cursor data) {
        cleanTable();
        TableLayout tableLayout=(TableLayout)findViewById(R.id.tableLayout);
        while (data.moveToNext()) {
            View tableRow = LayoutInflater.from(this).inflate(R.layout.table_item_quinta,null,false);
            TextView name  = (TextView) tableRow.findViewById(R.id.name);
            TextView direccion  = (TextView) tableRow.findViewById(R.id.direccion);

            name.setText(data.getString(1));
            direccion.setText(data.getString(2));
            tableLayout.addView(tableRow);

            String id = data.getString(0);
            tableRow.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    goToVerQuinta(id);
                }
            });

        }
    }

    public void goToVerQuinta(String id) {
        Intent intent = new Intent(this, VerQuinta.class);
        intent.putExtra("id",id);
        startActivity(intent);
    }

    /** Called when the user taps the Send button */
    public void goToCrearQuinta(View view) {
        Intent intent = new Intent(this, CrearQuinta.class);
        startActivity(intent);
    }

    public void siguiente(View view) {
        if (this.pagina < this.paginasTotales) {
            this.pagina++;
            cleanTable();
            consultarQuintas();
        } else {
            Toast.makeText(getApplicationContext(), "No hay mas elementos",Toast.LENGTH_SHORT).show();
        }
    }

    public void anterior(View view) {
        if (this.pagina > 1) {
            this.pagina--;
            cleanTable();
            consultarQuintas();
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