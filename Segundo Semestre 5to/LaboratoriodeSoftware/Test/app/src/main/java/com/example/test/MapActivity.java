package com.example.test;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.preference.PreferenceManager;
import android.view.View;
import android.widget.Toast;

import org.osmdroid.api.IMapController;
import org.osmdroid.events.MapEventsReceiver;
import org.osmdroid.util.GeoPoint;
import org.osmdroid.views.MapView;

import org.osmdroid.config.Configuration;
import org.osmdroid.tileprovider.tilesource.TileSourceFactory;
import org.osmdroid.views.overlay.ItemizedIconOverlay;
import org.osmdroid.views.overlay.ItemizedOverlayWithFocus;
import org.osmdroid.views.overlay.MapEventsOverlay;
import org.osmdroid.views.overlay.OverlayItem;

import java.util.ArrayList;
import java.util.HashMap;


public class MapActivity extends AppCompatActivity {

    MapView map = null;
    private HashMap datos = new HashMap();
    private String activity;
    private String id;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_map);

        Intent intent = getIntent();
        this.datos = (HashMap) intent.getSerializableExtra("datos");
        this.activity = intent.getStringExtra("activity");
        if (this.activity.equals("ver")) {
            this.id = intent.getStringExtra("id");
        }

        Context ctx = getApplicationContext();
        Configuration.getInstance().load(ctx, PreferenceManager.getDefaultSharedPreferences(ctx));
        map = (MapView) findViewById(R.id.map);
        map.setTileSource(TileSourceFactory.MAPNIK);
        map.setMultiTouchControls(true);
        IMapController mapController = map.getController();
        mapController.setZoom(15.5);
        GeoPoint startPoint = null;
        ArrayList<OverlayItem> puntos = new ArrayList<OverlayItem>();
        MapEventsReceiver mReceive = new MapEventsReceiver() {
            @Override
            public boolean singleTapConfirmedHelper(GeoPoint p) {
                puntos.add(new OverlayItem("", "", p));
                Toast.makeText(getBaseContext(),"Espere...",Toast.LENGTH_LONG).show();
                setPuntos(puntos);
                return false;
            }

            @Override
            public boolean longPressHelper(GeoPoint p) {
                return false;
            }
        };

        MapEventsOverlay OverlayEvents = new MapEventsOverlay(mReceive);
        map.getOverlays().add(OverlayEvents);

        if (!((HashMap) this.datos.get("quinta")).get("latitud").toString().equals("")) {
            startPoint = new GeoPoint( Double.parseDouble(((HashMap) this.datos.get("quinta")).get("latitud").toString()), Double.parseDouble(((HashMap) this.datos.get("quinta")).get("longitud").toString()));
            puntos.add(new OverlayItem("", "", startPoint));
            setPuntos(puntos);
        } else {
            startPoint = new GeoPoint(-34.9214, -57.9544);
        }
        mapController.setCenter(startPoint);
    }

    public void setPuntos(ArrayList<OverlayItem> puntos) {
        if (puntos.size() == 2) {
            puntos.remove(0);
            map.getOverlays().remove(1);
        }
        ((HashMap)this.datos.get("quinta")).put("latitud", puntos.get(0).getPoint().getLatitude());
        ((HashMap)this.datos.get("quinta")).put("longitud", puntos.get(0).getPoint().getLongitude());

        ItemizedIconOverlay.OnItemGestureListener<OverlayItem> tap =
                new ItemizedIconOverlay.OnItemGestureListener<OverlayItem>() {
                    public boolean onItemLongPress(int arg0, OverlayItem arg1) {
                        return false;
                    }
                    public boolean onItemSingleTapUp(int index, OverlayItem item) {
                        return false;
                    }
                };

        ItemizedOverlayWithFocus<OverlayItem> capa =
                new ItemizedOverlayWithFocus<OverlayItem>(this, puntos, tap);
        capa.setFocusItemsOnTap(true);
        this.map.getOverlays().add(capa);
    }

    public void backToCrearQuinta(View view) {
        Intent intent = null;
        if (this.activity.equals("ver")) {
            intent = new Intent(this, VerQuinta.class);
            intent.putExtra("id",this.id);
        } else {
            intent = new Intent(this, CrearQuinta.class);
        }
        intent.putExtra("datos", this.datos);
        startActivity(intent);
    }

}