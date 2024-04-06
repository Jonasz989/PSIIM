package backend.server.model.db;

import java.util.Set;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import jakarta.validation.constraints.Size;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Entity(name = "app_user")
@Getter
@Setter
public class AppUser {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;
	
	@Size(min=2, message = "Name should have atleast 2 characters")
	@JsonProperty("name")
	private String name;

	private String password;
	
	@JsonProperty("email")
	private String email;

	@ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	@JoinTable(name = "user_roles",
			joinColumns = @JoinColumn(name = "user_id", referencedColumnName = "id"),
			inverseJoinColumns = @JoinColumn(name = "role_id", referencedColumnName = "id"))
	private Set<AppRole> roles;


	@Override
	public String toString() {
		return "User [id=" + id + ", name=" + name + ", birthDate=" + email + "]";
	}
	
}


