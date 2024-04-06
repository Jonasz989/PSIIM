package backend.server.service;


import backend.server.model.payload.login.LoginDto;
import backend.server.model.payload.login.SignupDto;

public interface AuthService {
    String login(LoginDto loginDto);

    String register(SignupDto registerDto);
}
