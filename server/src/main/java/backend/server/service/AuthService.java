package backend.server.service;


import backend.server.model.login.LoginDto;
import backend.server.model.login.SignupDto;

public interface AuthService {
    String login(LoginDto loginDto);

    String register(SignupDto registerDto);
}
