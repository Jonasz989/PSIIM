package backend.server.controller;

import backend.server.model.db.AppUser;
import backend.server.security.JwtTokenProvider;
import backend.server.service.impl.AppUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api")
public class UserController {

    private final AppUserService appUserService;
    private final JwtTokenProvider jwtTokenProvider;

    @Autowired
    public UserController(AppUserService appUserService, JwtTokenProvider jwtTokenProvider) {
        this.appUserService = appUserService;
        this.jwtTokenProvider = jwtTokenProvider;
    }


    @GetMapping("/user")
    public ResponseEntity<AppUser> getUser(@RequestHeader("Authorization") String authorizationHeader) {
        // Extract the JWT token from the Authorization header
        String token = authorizationHeader.substring(7);

        // Validate the JWT token
        if (jwtTokenProvider.validateToken(token)) {
            // Extract the email address from the JWT token
            String email = jwtTokenProvider.getUsername(token);

            // Fetch the user information from the service layer
            AppUser userDto = appUserService.getUserByEmail(email);

            return ResponseEntity.ok(userDto);
        } else {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
        }
    }

}
