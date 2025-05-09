//Ecmascript module - habilitar en package.json
// "type": "module"
import express from 'express';
import medicamentosRoutes from './routes/medicamentos.routes.js';

const app = express();

app.use(express.json()); // Server recibe el JSON del cliente
app.use('/api/',medicamentosRoutes); //endpoint
export default app; //exportar la app para poder usarla en otro lado