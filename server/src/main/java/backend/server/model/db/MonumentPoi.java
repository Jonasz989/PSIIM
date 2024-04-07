package backend.server.model.db;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.geo.Point;

@Entity
@Table(name = "monument_pois")
@Getter
@Setter
public class MonumentPoi {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private long id;

    @Column(name = "name")
    @JsonProperty("name")
    private String name;

    @Column(name = "description")
    @JsonProperty("description")
    private String description;

    @Column(name = "photo")
    @JsonProperty("photo")
    private byte[] photo;

    @Column(name = "localization")
    @JsonProperty("localization")
    private Point localization;

    public MonumentPoi() {
    }

    public MonumentPoi(String name, String description, byte[] photo, Point localization) {
        this.name = name;
        this.description = description;
        this.photo = photo;
        this.localization = localization;
    }

    @Override
    public String toString() {
        return "MonumentPoi{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                '}';
    }
}
