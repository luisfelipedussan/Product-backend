const API_URL = 'http://localhost:8000/api';

class ApiService {
  constructor() {
    this.token = localStorage.getItem('token');
  }

  setToken(token) {
    this.token = token;
    localStorage.setItem('token', token);
  }

  clearToken() {
    this.token = null;
    localStorage.removeItem('token');
  }

  getHeaders() {
    const headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    if (this.token) {
      headers['Authorization'] = `Bearer ${this.token}`;
    }

    return headers;
  }

  async request(endpoint, options = {}) {
    try {
      const response = await fetch(`${API_URL}${endpoint}`, {
        ...options,
        headers: this.getHeaders(),
        credentials: 'include'
      });

      // Log para debugging
      console.log('Request Headers:', this.getHeaders());
      
      const data = await response.json();

      // Log para debugging
      console.log('API Response:', {
        status: response.status,
        data: data,
        endpoint: endpoint
      });

      if (!response.ok) {
        throw {
          response: {
            status: response.status,
            data: data
          },
          message: data.message || 'API request failed'
        };
      }

      return data;
    } catch (error) {
      console.error('API Error:', error);
      throw error;
    }
  }

  // Métodos específicos
  async login(credentials) {
    const data = await this.request('/login', {
      method: 'POST',
      body: JSON.stringify(credentials)
    });
    if (data.token) {
      this.setToken(data.token);
    }
    return data;
  }

  async logout() {
    await this.request('/logout', {
      method: 'POST'
    });
    this.clearToken();
  }
}

export const api = new ApiService(); 