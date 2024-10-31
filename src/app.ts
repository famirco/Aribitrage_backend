import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import configRoutes from './routes/config.routes';
import priceRoutes from './routes/price.routes';

dotenv.config();

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Routes
app.use('/api/v1/prices', priceRoutes);
app.use('/api/v1/config', configRoutes);

// Health check
app.get('/health', (req, res) => {
  res.json({ status: 'ok' });
});

const PORT = process.env.PORT || 3000;

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});

export default app;