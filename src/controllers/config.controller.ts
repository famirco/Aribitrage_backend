import { Request, Response } from 'express';
import { getTokens, getNetworks } from '../config/network';

export const getConfig = async (req: Request, res: Response) => {
  try {
    const config = {
      tokens: getTokens(),
      networks: getNetworks()
    };
    res.json(config);
  } catch (error) {
    res.status(500).json({ error: 'Failed to load configuration' });
  }
};