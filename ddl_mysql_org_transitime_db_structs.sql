
    alter table Block_to_Trip_joinTable 
        drop 
        foreign key FK_abaj8ke6oh4imbbgnaercsowo;

    alter table Block_to_Trip_joinTable 
        drop 
        foreign key FK_1c1e1twdap19vq0xkav0amvm;

    alter table TravelTimesForTrip_to_TravelTimesForPath_joinTable 
        drop 
        foreign key FK_hh5uepurijcqj0pyc6e3h5mqw;

    alter table TravelTimesForTrip_to_TravelTimesForPath_joinTable 
        drop 
        foreign key FK_9j1s8ewsmokqg4m35wrr29na7;

    alter table TripPattern_to_Path_joinTable 
        drop 
        foreign key FK_s0gaw8iv60vc17a5ltryqwg27;

    alter table TripPattern_to_Path_joinTable 
        drop 
        foreign key FK_qsr8l6u1nelb5pt8rlnei08sy;

    alter table Trips 
        drop 
        foreign key FK_p1er53449kkfsca6mbnxkdyst;

    alter table Trips 
        drop 
        foreign key FK_676npp7h4bxh8sjcnugnxt5wb;

    drop table if exists ActiveRevisions;

    drop table if exists Agencies;

    drop table if exists ArrivalsDepartures;

    drop table if exists AvlReports;

    drop table if exists Block_to_Trip_joinTable;

    drop table if exists Blocks;

    drop table if exists CalendarDates;

    drop table if exists Calendars;

    drop table if exists FareAttributes;

    drop table if exists FareRules;

    drop table if exists Frequencies;

    drop table if exists Matches;

    drop table if exists PredictionAccuracy;

    drop table if exists Predictions;

    drop table if exists Routes;

    drop table if exists StopPaths;

    drop table if exists Stops;

    drop table if exists Transfers;

    drop table if exists TravelTimesForStopPath;

    drop table if exists TravelTimesForTrip_to_TravelTimesForPath_joinTable;

    drop table if exists TravelTimesForTrips;

    drop table if exists TripPattern_to_Path_joinTable;

    drop table if exists TripPatterns;

    drop table if exists Trips;

    drop table if exists VehicleEvents;

    create table ActiveRevisions (
        configRev integer not null,
        travelTimesRev integer,
        primary key (configRev)
    );

    create table Agencies (
        configRev integer not null,
        agencyId varchar(60) not null,
        agencyFareUrl varchar(255),
        agencyLang varchar(15),
        agencyName varchar(60),
        agencyPhone varchar(15),
        agencyTimezone varchar(40),
        agencyUrl varchar(255),
        maxLat double precision,
        maxLon double precision,
        minLat double precision,
        minLon double precision,
        primary key (configRev, agencyId)
    );

    create table ArrivalsDepartures (
        DTYPE varchar(31) not null,
        vehicleId varchar(60) not null,
        tripId varchar(60) not null,
        time datetime(3) not null,
        stopId varchar(60) not null,
        isArrival boolean not null,
        gtfsStopSeq integer not null,
        avlTime datetime(3),
        blockId varchar(60),
        configRev integer,
        directionId varchar(60),
        routeId varchar(60),
        routeShortName varchar(60),
        scheduledTime datetime(3),
        serviceId varchar(60),
        stopPathIndex integer,
        stopPathLength float,
        tripIndex integer,
        primary key (vehicleId, tripId, time, stopId, isArrival, gtfsStopSeq)
    );

    create table AvlReports (
        vehicleId varchar(60) not null,
        time datetime(3) not null,
        assignmentId varchar(60),
        assignmentType varchar(40),
        driverId varchar(60),
        field1Name varchar(60),
        field1Value varchar(60),
        heading float,
        licensePlate varchar(10),
        lat double precision,
        lon double precision,
        passengerCount integer,
        passengerFullness float,
        speed float,
        timeProcessed datetime(3),
        primary key (vehicleId, time)
    );

    create table Block_to_Trip_joinTable (
        Blocks_serviceId varchar(60) not null,
        Blocks_configRev integer not null,
        Blocks_blockId varchar(60) not null,
        trips_tripId varchar(60) not null,
        trips_startTime integer not null,
        trips_configRev integer not null,
        listIndex integer not null,
        primary key (Blocks_serviceId, Blocks_configRev, Blocks_blockId, listIndex)
    );

    create table Blocks (
        serviceId varchar(60) not null,
        configRev integer not null,
        blockId varchar(60) not null,
        endTime integer,
        headwaySecs integer,
        routeIds blob,
        startTime integer,
        primary key (serviceId, configRev, blockId)
    );

    create table CalendarDates (
        serviceId varchar(60) not null,
        date date not null,
        configRev integer not null,
        exceptionType varchar(2),
        primary key (serviceId, date, configRev)
    );

    create table Calendars (
        wednesday boolean not null,
        tuesday boolean not null,
        thursday boolean not null,
        sunday boolean not null,
        startDate date not null,
        serviceId varchar(60) not null,
        saturday boolean not null,
        monday boolean not null,
        friday boolean not null,
        endDate date not null,
        configRev integer not null,
        primary key (wednesday, tuesday, thursday, sunday, startDate, serviceId, saturday, monday, friday, endDate, configRev)
    );

    create table FareAttributes (
        fareId varchar(60) not null,
        configRev integer not null,
        currencyType varchar(3),
        paymentMethod varchar(255),
        price float,
        transferDuration integer,
        transfers varchar(255),
        primary key (fareId, configRev)
    );

    create table FareRules (
        routeId varchar(60) not null,
        originId varchar(60) not null,
        fareId varchar(60) not null,
        destinationId varchar(60) not null,
        configRev integer not null,
        containsId varchar(60),
        primary key (routeId, originId, fareId, destinationId, configRev)
    );

    create table Frequencies (
        tripId varchar(60) not null,
        startTime integer not null,
        configRev integer not null,
        endTime integer,
        exactTimes boolean,
        headwaySecs integer,
        primary key (tripId, startTime, configRev)
    );

    create table Matches (
        vehicleId varchar(60) not null,
        avlTime datetime(3) not null,
        blockId varchar(60),
        configRev integer,
        distanceAlongSegment float,
        distanceAlongStopPath float,
        segmentIndex integer,
        serviceId varchar(255),
        stopPathIndex integer,
        tripId varchar(60),
        primary key (vehicleId, avlTime)
    );

    create table PredictionAccuracy (
        id bigint not null auto_increment,
        arrivalDepartureTime datetime(3),
        directionId varchar(60),
        predictedTime datetime(3),
        predictionAccuracyMsecs integer,
        predictionReadTime datetime(3),
        predictionSource varchar(60),
        routeId varchar(60),
        stopId varchar(60),
        vehicleId varchar(60),
        primary key (id)
    );

    create table Predictions (
        id bigint not null auto_increment,
        affectedByWaitStop boolean,
        configRev integer,
        creationTime datetime(3),
        isArrival boolean,
        predictionTime datetime(3),
        routeId varchar(60),
        stopId varchar(60),
        tripId varchar(60),
        vehicleId varchar(60),
        primary key (id)
    );

    create table Routes (
        id varchar(60) not null,
        configRev integer not null,
        color varchar(10),
        description varchar(255),
        maxLat double precision,
        maxLon double precision,
        minLat double precision,
        minLon double precision,
        hidden boolean,
        maxDistance double precision,
        name varchar(255),
        routeOrder integer,
        shortName varchar(80),
        textColor varchar(10),
        type varchar(2),
        primary key (id, configRev)
    );

    create table StopPaths (
        tripPatternId varchar(60) not null,
        stopPathId varchar(60) not null,
        configRev integer not null,
        breakTime integer,
        gtfsStopSeq integer,
        lastStopInTrip boolean,
        layoverStop boolean,
        locations blob,
        pathLength double precision,
        routeId varchar(60),
        scheduleAdherenceStop boolean,
        stopId varchar(60),
        waitStop boolean,
        primary key (tripPatternId, stopPathId, configRev)
    );

    create table Stops (
        id varchar(60) not null,
        configRev integer not null,
        code integer,
        hidden boolean,
        layoverStop boolean,
        lat double precision,
        lon double precision,
        name varchar(255),
        timepointStop boolean,
        waitStop boolean,
        primary key (id, configRev)
    );

    create table Transfers (
        toStopId varchar(60) not null,
        fromStopId varchar(60) not null,
        configRev integer not null,
        minTransferTime integer,
        transferType varchar(1),
        primary key (toStopId, fromStopId, configRev)
    );

    create table TravelTimesForStopPath (
        id integer not null auto_increment,
        daysOfWeekOverride smallint,
        howSet varchar(5),
        stopPathId varchar(60),
        stopTimeMsec integer,
        travelTimeSegmentLength float,
        travelTimesMsec blob,
        primary key (id)
    );

    create table TravelTimesForTrip_to_TravelTimesForPath_joinTable (
        TravelTimesForTrips_id integer not null,
        travelTimesForStopPaths_id integer not null,
        listIndex integer not null,
        primary key (TravelTimesForTrips_id, listIndex)
    );

    create table TravelTimesForTrips (
        id integer not null auto_increment,
        configRev integer,
        travelTimesRev integer,
        tripCreatedForId varchar(60),
        tripPatternId varchar(60),
        primary key (id)
    );

    create table TripPattern_to_Path_joinTable (
        TripPatterns_id varchar(60) not null,
        TripPatterns_configRev integer not null,
        stopPaths_tripPatternId varchar(60) not null,
        stopPaths_stopPathId varchar(60) not null,
        stopPaths_configRev integer not null,
        listIndex integer not null,
        primary key (TripPatterns_id, TripPatterns_configRev, listIndex)
    );

    create table TripPatterns (
        id varchar(60) not null,
        configRev integer not null,
        shapeId varchar(60),
        directionId varchar(60),
        maxLat double precision,
        maxLon double precision,
        minLat double precision,
        minLon double precision,
        headsign varchar(255),
        routeId varchar(60),
        routeShortName varchar(80),
        primary key (id, configRev)
    );

    create table Trips (
        tripId varchar(60) not null,
        startTime integer not null,
        configRev integer not null,
        blockId varchar(60),
        directionId varchar(60),
        endTime integer,
        headsign varchar(255),
        routeId varchar(60),
        routeShortName varchar(60),
        scheduledTimesMap blob,
        serviceId varchar(60),
        shapeId varchar(60),
        travelTimes_id integer,
        tripPattern_id varchar(60),
        tripPattern_configRev integer,
        primary key (tripId, startTime, configRev)
    );

    create table VehicleEvents (
        vehicleId varchar(60) not null,
        time datetime(3) not null,
        eventType varchar(60) not null,
        becameUnpredictable boolean,
        blockId varchar(60),
        description longtext,
        lat double precision,
        lon double precision,
        predictable boolean,
        routeId varchar(60),
        routeShortName varchar(60),
        stopId varchar(60),
        supervisor varchar(60),
        tripId varchar(60),
        primary key (vehicleId, time, eventType)
    );

    create index ArrivalsDeparturesTimeIndex on ArrivalsDepartures (time);

    create index AvlReportsTimeIndex on AvlReports (time);

    alter table Block_to_Trip_joinTable 
        add index FK_abaj8ke6oh4imbbgnaercsowo (trips_tripId, trips_startTime, trips_configRev), 
        add constraint FK_abaj8ke6oh4imbbgnaercsowo 
        foreign key (trips_tripId, trips_startTime, trips_configRev) 
        references Trips (tripId, startTime, configRev);

    alter table Block_to_Trip_joinTable 
        add index FK_1c1e1twdap19vq0xkav0amvm (Blocks_serviceId, Blocks_configRev, Blocks_blockId), 
        add constraint FK_1c1e1twdap19vq0xkav0amvm 
        foreign key (Blocks_serviceId, Blocks_configRev, Blocks_blockId) 
        references Blocks (serviceId, configRev, blockId);

    create index avlTimeIndex on Matches (avlTime);

    create index PredictionAccuracyTimeIndex on PredictionAccuracy (arrivalDepartureTime);

    alter table TravelTimesForTrip_to_TravelTimesForPath_joinTable 
        add index FK_hh5uepurijcqj0pyc6e3h5mqw (travelTimesForStopPaths_id), 
        add constraint FK_hh5uepurijcqj0pyc6e3h5mqw 
        foreign key (travelTimesForStopPaths_id) 
        references TravelTimesForStopPath (id);

    alter table TravelTimesForTrip_to_TravelTimesForPath_joinTable 
        add index FK_9j1s8ewsmokqg4m35wrr29na7 (TravelTimesForTrips_id), 
        add constraint FK_9j1s8ewsmokqg4m35wrr29na7 
        foreign key (TravelTimesForTrips_id) 
        references TravelTimesForTrips (id);

    create index travelTimesRevIndex on TravelTimesForTrips (travelTimesRev);

    alter table TripPattern_to_Path_joinTable 
        add constraint UK_s0gaw8iv60vc17a5ltryqwg27 unique (stopPaths_tripPatternId, stopPaths_stopPathId, stopPaths_configRev);

    alter table TripPattern_to_Path_joinTable 
        add index FK_s0gaw8iv60vc17a5ltryqwg27 (stopPaths_tripPatternId, stopPaths_stopPathId, stopPaths_configRev), 
        add constraint FK_s0gaw8iv60vc17a5ltryqwg27 
        foreign key (stopPaths_tripPatternId, stopPaths_stopPathId, stopPaths_configRev) 
        references StopPaths (tripPatternId, stopPathId, configRev);

    alter table TripPattern_to_Path_joinTable 
        add index FK_qsr8l6u1nelb5pt8rlnei08sy (TripPatterns_id, TripPatterns_configRev), 
        add constraint FK_qsr8l6u1nelb5pt8rlnei08sy 
        foreign key (TripPatterns_id, TripPatterns_configRev) 
        references TripPatterns (id, configRev);

    alter table Trips 
        add index FK_p1er53449kkfsca6mbnxkdyst (travelTimes_id), 
        add constraint FK_p1er53449kkfsca6mbnxkdyst 
        foreign key (travelTimes_id) 
        references TravelTimesForTrips (id);

    alter table Trips 
        add index FK_676npp7h4bxh8sjcnugnxt5wb (tripPattern_id, tripPattern_configRev), 
        add constraint FK_676npp7h4bxh8sjcnugnxt5wb 
        foreign key (tripPattern_id, tripPattern_configRev) 
        references TripPatterns (id, configRev);

    create index VehicleEventsTimeIndex on VehicleEvents (time);
