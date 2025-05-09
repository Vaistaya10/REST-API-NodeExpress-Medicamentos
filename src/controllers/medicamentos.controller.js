import { pool } from '../db.js';

export const getMedicamentos = async (req, res) => {
  try {
    const querySQL = `SELECT * FROM vwMedicamentos`;
    const [rows] = await pool.query(querySQL);
    res.json(rows);
  } catch (error) {
    return res.status(500).json({ message: 'Error al obtener los medicamentos' });
  }
};

export const getMedicamentoById = async (req,res) => {
try {
  const id = req.params.id
  const querySQL = `call spGetMedicamentoById(?)`
  const [results] = await pool.query(querySQL,id)

  if (results.length == 0) {
    return res.status(404).json({
      message : "El ID enviado NO Existe"
    })
  }
  res.send(results[0])
} catch (error) {
  console.error("No se puedo concretar GET")
}
};

export const getMedicamentosByReceta = async (req,res) => {
try {
  const receta = req.params.receta
  const querySQL = `call spGetMedicamentosByReceta(?)`
  const [results] = await pool.query(querySQL,receta)

  if (results.length == 0) {
    return res.status(404).json({
      message : "error al traer los medicamentos por la receta"
    })
  }
  res.send(results[0])
} catch (error) {
  console.error("No se puedo concretar GET")
}
};

export const getMedicamentosBytipo = async (req,res) => {
try {
  const tipo = req.params.tipo
  const querySQL = `call spGetMedicamentosByTipo(?)`
  const [results] = await pool.query(querySQL,tipo)

  if (results.length == 0) {
    return res.status(404).json({
      message : "Tipo incorrecto"
    })
  }
  res.send(results[0])
} catch (error) {
  console.error("No se puedo concretar GET")
}
};


export const registerMedicamento = async(req,res) => {
  try {
    const querySQL = 'call spRegisterMedicamento(?,?,?,?,?,?)'
    const {tipo,nombre,nomcomercial,presentacion,receta,precio} = req.body
    const [results] = await pool.query(querySQL, [tipo,nombre,nomcomercial,presentacion,receta,precio]);

    if (results.affectedRows = 0) {
      res.send({
        status: false,
        message: "No se pudo completar el proceso",
        id: null
      })
    } else {
      res.send({
        status : true,
        message : "Registrado correctamente"
      })
    }
  } catch {
    console.error("No se pudo concretar POST")
  }
};

export const updateMedicamento = async(req,res) => {

};
