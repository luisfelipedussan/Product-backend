export const AuthProvider = ({ children }) => {
  // ... otros estados y métodos ...

  const login = async (credentials) => {
    try {
      const response = await api.post('/login', credentials);
      console.log('Respuesta del servidor:', response);

      // Verificar que la respuesta tenga el formato esperado
      if (response?.status === 'success' && response?.token) {
        localStorage.setItem('token', response.token);
        api.setToken(response.token);
        setUser(response.user);
        return response;
      } else {
        throw new Error('Respuesta inválida del servidor');
      }
    } catch (error) {
      console.error('Error en login:', error);
      // Propagar el error para que el componente Login pueda manejarlo
      throw error;
    }
  };

  // ... resto del contexto ...
}; 