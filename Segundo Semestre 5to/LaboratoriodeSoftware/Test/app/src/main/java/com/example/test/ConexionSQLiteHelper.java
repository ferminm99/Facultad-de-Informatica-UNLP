package com.example.test;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;
import android.os.Bundle;
import android.widget.Toast;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

public class ConexionSQLiteHelper extends SQLiteOpenHelper {

    final String CREAR_TABLA_PARCELA="CREATE TABLE parcelas (id Integer PRIMARY KEY AUTOINCREMENT, descripcion TEXT, cubierta TEXT, FOREIGN KEY (id) REFERENCES quintas_parcelas (idParcela) ON UPDATE CASCADE ON DELETE RESTRICT)";
    final String CREAR_TABLA_VERDURA="CREATE TABLE verduras (id Integer PRIMARY KEY AUTOINCREMENT, descripcion TEXT, siembra TEXT, cosecha TEXT, FOREIGN KEY (id) REFERENCES quintas_parcelas (idVerdura) ON UPDATE CASCADE ON DELETE RESTRICT, FOREIGN KEY (id) REFERENCES bolsones_verduras (idVerdura) ON UPDATE CASCADE ON DELETE RESTRICT)";
    final String CREAR_TABLA_QUINTA="CREATE TABLE quintas (id Integer PRIMARY KEY AUTOINCREMENT, nombre TEXT, direccion TEXT, superficie Real, latitud Real, longitud Real)";
    final String CREAR_TABLA_QUINTA_PARCELA="CREATE TABLE quintas_parcelas (id Integer PRIMARY KEY AUTOINCREMENT, idQuinta Integer, idParcela Integer, idVerdura Integer, cantidadSurcos Integer, superficieParcela Real)";
    final String CREAR_TABLA_QUINTA_BOLSON="CREATE TABLE bolsones (id Integer PRIMARY KEY AUTOINCREMENT, idQuinta Integer, vigencia Integer, cantidad Integer, mes TEXT)";
    final String CREAR_TABLA_BOLSON_VERDURA="CREATE TABLE bolsones_verduras (id Integer PRIMARY KEY AUTOINCREMENT, nombre TEXT, idBolson Integer, cantidad Integer, FOREIGN KEY (idBolson) REFERENCES bolsones (id) ON UPDATE CASCADE ON DELETE CASCADE)";
    final String CREAR_TABLA_VISITAS="CREATE TABLE visitas (id Integer PRIMARY KEY AUTOINCREMENT, idQuinta Integer, tecnico TEXT, mes TEXT, FOREIGN KEY (id) REFERENCES registro (idVisita) ON UPDATE CASCADE ON DELETE CASCADE)";
    final String CREAR_TABLA_REGISTRO="CREATE TABLE registro (id Integer PRIMARY KEY AUTOINCREMENT, idVisita Integer, verdura TEXT, enCosecha TEXT)";

    public ConexionSQLiteHelper(@Nullable Context context, @Nullable String name, @Nullable SQLiteDatabase.CursorFactory factory, int version) {
        super(context, name, factory, version);
    }

    @Override
    public void onCreate(SQLiteDatabase db) {
        db.execSQL(CREAR_TABLA_PARCELA);
        db.execSQL(CREAR_TABLA_VERDURA);
        db.execSQL(CREAR_TABLA_QUINTA);
        db.execSQL(CREAR_TABLA_QUINTA_PARCELA);
        db.execSQL(CREAR_TABLA_QUINTA_BOLSON);
        db.execSQL(CREAR_TABLA_BOLSON_VERDURA);
        db.execSQL(CREAR_TABLA_VISITAS);
        db.execSQL(CREAR_TABLA_REGISTRO);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("DROP TABLE IF EXISTS parcelas");
        db.execSQL("DROP TABLE IF EXISTS verduras");
        db.execSQL("DROP TABLE IF EXISTS quintas");
        db.execSQL("DROP TABLE IF EXISTS quintas_parcelas");
        db.execSQL("DROP TABLE IF EXISTS bolsones");
        db.execSQL("DROP TABLE IF EXISTS bolsones_verduras");
        db.execSQL("DROP TABLE IF EXISTS visitas");
        db.execSQL("DROP TABLE IF EXISTS registro");
        onCreate(db);
    }

}
