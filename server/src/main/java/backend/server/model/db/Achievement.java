package backend.server.model.db;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import jakarta.validation.constraints.Size;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;


@Data
@Entity(name = "achievements")
@Getter
@Setter
public class Achievement {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Size(min=2, message = "Name should have atleast 2 characters")
    @JsonProperty("name")
    private String name;

    @JsonProperty("description")
    private String description;

    @JsonProperty("photo")
    private byte[] photo;

    @JsonProperty("points")
    private int points;

    @JsonProperty("date")
    private LocalDateTime date;

    @ManyToOne
    @JoinColumn(name = "user_id", referencedColumnName = "id")
    private AppUser user;

    @ManyToOne
    @JoinColumn(name = "monument_pois", referencedColumnName = "id")
    private MonumentPoi monumentPoi;

    @Override
    public String toString() {
        return "Achievement{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", points=" + points +
                ", date=" + date +
                '}';
    }




}
