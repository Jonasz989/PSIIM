package backend.server.model.db;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

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

    @Column(name = "lon")
    @JsonProperty("lon")
    private double lon;

    @Column(name = "lat")
    @JsonProperty("lat")
    private double lat;


    public MonumentPoi() {
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
