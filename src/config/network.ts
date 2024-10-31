interface TokenConfig {
  id: number;
  symbol: string;
  name: string;
}

interface NetworkConfig {
  rpcUrl: string;
  name: string;
}

export const getTokens = (): TokenConfig[] => {
  try {
    return JSON.parse(process.env.TOKENS || '[]');
  } catch (error) {
    console.error('Error parsing TOKENS from env:', error);
    return [];
  }
};

export const getNetworks = (): NetworkConfig[] => {
  try {
    return JSON.parse(process.env.NETWORKS || '[]');
  } catch (error) {
    console.error('Error parsing NETWORKS from env:', error);
    return [];
  }
};