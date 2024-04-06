package backend.server.service.impl;

import backend.server.exception.ServerException;
import backend.server.model.db.AppRole;
import backend.server.model.db.AppUser;
import backend.server.model.payload.login.LoginDto;
import backend.server.model.payload.login.SignupDto;
import backend.server.repository.AppRoleRepository;
import backend.server.repository.AppUserRepository;
import backend.server.security.JwtTokenProvider;
import backend.server.service.AuthService;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.HashSet;
import java.util.Set;

@Service
public class AuthServiceImpl implements AuthService {

    private AuthenticationManager authenticationManager;
    private AppUserRepository userRepository;
    private AppRoleRepository roleRepository;
    private PasswordEncoder passwordEncoder;
    private JwtTokenProvider jwtTokenProvider;


    public AuthServiceImpl(AuthenticationManager authenticationManager,
                           AppUserRepository userRepository,
                           AppRoleRepository roleRepository,
                           PasswordEncoder passwordEncoder,
                           JwtTokenProvider jwtTokenProvider) {
        this.authenticationManager = authenticationManager;
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
        this.passwordEncoder = passwordEncoder;
        this.jwtTokenProvider = jwtTokenProvider;
    }

    @Override
    public String login(LoginDto loginDto) {

        Authentication authentication = authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(
                loginDto.getUsernameOrEmail(), loginDto.getPassword()));

        SecurityContextHolder.getContext().setAuthentication(authentication);

        String token = jwtTokenProvider.generateToken(authentication);

        return token;
    }

    @Override
    public String register(SignupDto registerDto) {

        // add check for username exists in database
        if(userRepository.existsByName(registerDto.getName())){
            throw new ServerException(HttpStatus.BAD_REQUEST, "Username is already exists!.");
        }

        // add check for email exists in database
        if(userRepository.existsByEmail(registerDto.getEmail())){
            throw new ServerException(HttpStatus.BAD_REQUEST, "Email is already exists!.");
        }

        AppUser user = new AppUser();
        user.setName(registerDto.getName());
        user.setEmail(registerDto.getEmail());
        user.setPassword(passwordEncoder.encode(registerDto.getPassword()));

        Set<AppRole> roles = new HashSet<>();

        if (user.getEmail().contains("admin")) {
            AppRole adminRole = roleRepository.findByName("ROLE_ADMIN").get();
            roles.add(adminRole);
        }

        AppRole userRole = roleRepository.findByName("ROLE_USER").get();
        roles.add(userRole);
        user.setRoles(roles);

        userRepository.save(user);

        return "User registered successfully!.";
    }
}