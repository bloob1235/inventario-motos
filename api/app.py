
import os
import psycopg2
from flask import Flask, jsonify, request
from datetime import date

app = Flask(__name__)

def conectar():
    return psycopg2.connect(
        host=os.getenv("DB_HOST", "db"),
        database=os.getenv("DB_NAME", "inventario"),
        user=os.getenv("DB_USER", "admin"),
        password=os.getenv("DB_PASSWORD", "motos123")
    )

@app.route("/api/refacciones", methods=["GET", "POST"])
def refacciones():
    conn = conectar()
    cur = conn.cursor()

    if request.method == "POST":
        datos = request.get_json(silent=True) or {}
        campos = ["nombre", "categoria", "marca", "precio", "stock"]

        if any(campo not in datos for campo in campos):
            cur.close()
            conn.close()
            return jsonify({"error": "Faltan campos"}), 400

        try:
            cur.execute("""
                INSERT INTO refacciones
                (nombre, categoria, marca, precio, stock)
                VALUES (%s, %s, %s, %s, %s)
                RETURNING id;
            """, (
                datos["nombre"], datos["categoria"], datos["marca"],
                datos["precio"], datos["stock"]
            ))
            nuevo_id = cur.fetchone()[0]
            conn.commit()
            cur.close()
            conn.close()
            return jsonify({"mensaje": "Refacción registrada", "id": nuevo_id}), 201
        except Exception as e:
            conn.rollback()
            cur.close()
            conn.close()
            return jsonify({"error": str(e)}), 400

    cur.execute("""
        SELECT id, nombre, categoria, marca, precio, stock
        FROM refacciones ORDER BY nombre;
    """)
    filas = cur.fetchall()
    cur.close()
    conn.close()

    return jsonify([
        {
            "id": f[0], "nombre": f[1], "categoria": f[2],
            "marca": f[3], "precio": float(f[4]), "stock": f[5]
        }
        for f in filas
    ])

@app.route("/api/resumen")
def resumen():
    conn = conectar()
    cur = conn.cursor()
    cur.execute("""
        SELECT COUNT(*), COALESCE(SUM(stock), 0),
               COALESCE(SUM(precio * stock), 0)
        FROM refacciones;
    """)
    total, unidades, valor = cur.fetchone()
    cur.close()
    conn.close()
    return jsonify({
        "total": total, "unidades": int(unidades), "valor": float(valor)
    })

@app.route("/api/compras")
def compras():
    conn = conectar()
    cur = conn.cursor()
    cur.execute("""
        SELECT categoria, SUM(cantidad * precio_unitario) AS gasto
        FROM compras
        WHERE fecha >= date_trunc('month', CURRENT_DATE)
          AND fecha < date_trunc('month', CURRENT_DATE) + INTERVAL '1 month'
        GROUP BY categoria
        ORDER BY categoria;
    """)
    filas = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify([
        {"categoria": f[0], "gasto": float(f[1])}
        for f in filas
    ])

@app.route("/api/estado")
def estado():
    return jsonify({"servidor": "activo"})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)

