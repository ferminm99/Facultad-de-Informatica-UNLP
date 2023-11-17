package laboratorio.modelo;

import java.util.*;

public class Buscador {
    private ArrayList<Pelicula> peliculas;

    public Buscador() {
        // init buscador por defecto con peliculas de muestra
        peliculas = new ArrayList<Pelicula>();
        ArrayList<Genero> a1 = new ArrayList<Genero>();
        a1.add(Genero.ACCION);
        a1.add(Genero.SUSPENSO);
        ArrayList<Genero> a2 = new ArrayList<Genero>();
        a2.add(Genero.ROMANCE);
        a2.add(Genero.COMEDIA);
        Pelicula p1 = new Pelicula(a1, EdadEspectador.ATP, 5.0, 5, "lala1", "pais1", 2000);
        Pelicula p2 = new Pelicula(a1, EdadEspectador.ATP, 5.0, 6, "lala2", "pais2", 2001);
        Pelicula p3 = new Pelicula(a2, EdadEspectador.MAS13, 2.0, 10, "lala land1", "pais1", 2002);
        Pelicula p4 = new Pelicula(a2, EdadEspectador.MAS13, 3.0, 589, "lala land2", "pais2", 2003);
        Pelicula p5 = new Pelicula(a2, EdadEspectador.MAS16, 5.0, 9, "lala land3", "pais3", 2010);
        Pelicula p6 = new Pelicula(a2, EdadEspectador.MAS16, 3.5, 1000, "lala land4", "pais4", 2015);
        Pelicula p7 = new Pelicula(a2, EdadEspectador.MAS18, 3.7, 8, "lala land5", "pais5", 2000);
        Pelicula p8 = new Pelicula(a2, EdadEspectador.MAS18, 3.0, 399, "lala land6", "pai6", 2018);
        Pelicula p9 = new Pelicula(a2, EdadEspectador.MAS18, 3.8, 25, "lala land7", "pais7", 2007);
        Pelicula p10 = new Pelicula(a2, EdadEspectador.MAS18, 3.0, 9, "lala land8", "pais8", 2008);
        ArrayList<Pelicula> a3 = new ArrayList<Pelicula>();
        peliculas.add(p1);
        peliculas.add(p2);
        peliculas.add(p3);
        peliculas.add(p4);
        peliculas.add(p5);
        peliculas.add(p6);
        peliculas.add(p7);
        peliculas.add(p8);
        peliculas.add(p9);
        peliculas.add(p10);
    }

    public Buscador(ArrayList<Pelicula> peliculas) {
        this.peliculas = peliculas;
    }

    public ArrayList<Pelicula> getPeliculas() {
        return peliculas;
    }

    public void setPeliculas(ArrayList<Pelicula> peliculas) {
        this.peliculas = peliculas;
    }

    public ArrayList<Pelicula> seleccionar(Genero g, EdadEspectador e, Rango valoracion, Rango reproduccion, Comparator<Pelicula> comp){

        ArrayList<Pelicula> aux = new ArrayList<Pelicula>();
        for (int i = 0; i < peliculas.size(); i++) {
            Pelicula p = peliculas.get(i);
            if (p.getGeneros().contains(g) && p.getEdadEspectador().equals(e) && inRange(p.getValoracion(),valoracion) && inRange(p.getCantReproducciones(),reproduccion)){
                aux.add(p);
            }
        }
        Collections.sort(aux, comp);
        return aux;
    }

    public boolean inRange(double n, Rango r){
        n = (int) n;
        return n >= r.getLimiteInferior() && n <= r.getLimiteSuperor();
    }

    public enum Comparador1 implements Comparator<Pelicula>{
        INSTANCE;

        @Override
        public int compare(Pelicula o1, Pelicula o2) {
            return o2.getCantReproducciones() - o1.getCantReproducciones();
        }
    }

    public enum Comparador2 implements Comparator<Pelicula>{
        INSTANCE;

        @Override
        public int compare(Pelicula o1, Pelicula o2) {
            return o2.getTitulo().compareTo(o1.getTitulo());
        }
    }
}
