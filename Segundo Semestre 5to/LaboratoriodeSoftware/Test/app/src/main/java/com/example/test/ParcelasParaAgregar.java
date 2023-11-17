package com.example.test;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.TableLayout;
import android.widget.TextView;
import android.widget.Toast;

import java.util.HashMap;

public class ParcelasParaAgregar extends AppCompatActivity {

    private int pagina = 1;
    private double paginasTotales = 1;
    private HashMap datos = new HashMap();
    private String activity;
    private String id;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_parcelas_para_agregar);

        Intent intent = getIntent();
        this.datos = (HashMap) intent.getSerializableExtra("datos");

        this.activity = intent.getStringExtra("activity");
        if (this.activity.equals("ver")) {
            this.id = intent.getStringExtra("id");
        }

        consultarParcelas();

    }

    private void consultarParcelas() {
        SQLiteDatabase db = MainActivity.conn.getReadableDatabase();
        setPaginasTotales(db);
        TableLayout tableLayout=(TableLayout)findViewById(R.id.tableLayout);
        Cursor data = db.rawQuery("SELECT * FROM parcelas LIMIT 12 OFFSET "+(pagina - 1)*12, null);

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
                    goToAgregarDatosParcela(id);
                }
            });

        }
        data.close();
    }

    public void goToAgregarDatosParcela(String id) {
        Intent intent = new Intent(this, AgregarDatosParcela.class);
        intent.putExtra("idParcela",id);
        intent.putExtra("id",this.id);
        intent.putExtra("activity",this.activity);
        intent.putExtra("datos",this.datos);
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

    private void setPaginasTotales(SQLiteDatabase db) {
        Cursor data = db.rawQuery("SELECT count(*) as paginas FROM parcelas", null);
        data.moveToFirst();
        this.paginasTotales = Math.ceil(((double) data.getDouble(0) / (double) 12));
    }
}