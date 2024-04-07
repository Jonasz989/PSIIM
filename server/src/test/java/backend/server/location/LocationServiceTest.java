package backend.server.location;

import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.springframework.data.geo.Point;

public class LocationServiceTest {

    private LocationService locationService = new LocationService();

    @Test
    public void testCalculateDistanceBetween2PointsInMeters() {

        double lat1 = 1.00000000001;
        double lon1 = 1.0;
        double lat2 = 1.0;
        double lon2 = 1.0;

        double distance = locationService.calculateDistanceBetween2PointsInMeters(lat1, lon1, lat2, lon2);

        System.out.println("Distance: " + distance);
        Assertions.assertNotEquals(0.0, distance);

    }

    @Test
    public void testCalculateDistanceBetween2PointsInMetersPoints() {

        Point p1 = new Point(-122.1697, 37.4275); // San Francisco
        Point p2 = new Point(-73.9822, 40.7278); //New York
        //4,129.06 km about 4,129,060 meters

        double distance = locationService.calculateDistanceBetween2PointsInMeters(p1.getY(), p1.getX(), p2.getY(), p2.getX());

        System.out.println("Distance: " + distance);
        Assertions.assertEquals(412906.0, distance, 1000);

    }

}
