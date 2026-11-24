import express from 'express'
import clienteRoutes from './modules/clientes/cliente.routes.js'
import produtoRoutes from './modules/produtos/produto.route.js'
import mesaRoutes from './modules/mesas/mesa.route.js'

import morgan from 'morgan'


const app = express();
app.use(express.json());
app.use(morgan("dev"))

app.use('/clientes', clienteRoutes)
app.use('/produtos', produtoRoutes)
app.use('/mesas', mesaRoutes)


export default app;