import React, { useState } from "react";
import { ApolloClient, InMemoryCache, useQuery, useLazyQuery, gql } from "@apollo/client";
import "./Overview.css";

const client = new ApolloClient({
  uri: '/graphql',
  cache: new InMemoryCache()
});

const ALL_PEOPLE = gql`
  query allPeople {
    allRiders {
      name
      address
      preferences {
        name
      }
    }
    allDrivers {
      name
      address
      preferences {
        name
      }
    }
  }
`;

const ASSIGN_PARTICIPANTS = gql`
  query fetchAssignments {
    organize {
      id
      driver {
        name
      }
      riders {
        name
      }
    }
  }
`;

function Overview() {

  const [newParticipant, setParticipant] = useState({
    name: '',
    address: '',
    type: 'rider',
    totalSpace: 0,
    preferences: []
  });

  const onChange = ({ target }) => {
    const origin = target.name;
    const value = transform(origin, target.value);

    setParticipant({
      ...newParticipant,
      [origin]: value, 
    })
  }

  const transform = (origin, val) => {
    console.log(origin)

    switch (origin) {
      case 'totalSpace':
        return parseInt(val);
      case 'preferences':
        return val.split(',').map(el => (el.trim())) // TODO: tidy
      default: 
        return val;
    }
  }

  const onAddParticipant = (event) => {
    event.preventDefault();
    console.log(newParticipant);

  }

  const { loading, error, data } = useQuery(ALL_PEOPLE, { client });
  const [getAssignments, { loading: loadingAssignments, data: assignments }] = useLazyQuery(ASSIGN_PARTICIPANTS, { client });

  if (loading) {
    return <div>Loading...</div>
  }

  if (error) {
    return <div>Error!</div>
  }

  return (
    <div>
      <h1>Participants</h1>
      <p>Riders ({data && data.allRiders.length}):</p>
      <ul>
        {
        data && data.allRiders.map(rider => 
            <li key={rider.name}>{rider.name} / {rider.address}</li>
          )
        }
      </ul>
      <p>Drivers ({data && data.allDrivers.length}):</p>
      <ul>
        {
        data && data.allDrivers.map(driver => 
            <li key={driver.name}>{driver.name} / {driver.address}</li>
          )
        }
      </ul>
      <form onSubmit={onAddParticipant}>
        <h3>Add Participant</h3>
        <input name="name" type="text" onChange={onChange} value={newParticipant.name} placeholder="Name" />
        <input name="address" type="text" onChange={onChange} value={newParticipant.address} placeholder="Address" />
        <select name="type" onChange={onChange} value={newParticipant.type}>
          <option value="rider">Rider</option>
          <option value="driver">Driver</option>
        </select>
        <input name="totalSpace" disabled={newParticipant.type == 'rider'} onChange={onChange} value={newParticipant.totalSpace} min={0} max={100} type="number" />
        <input name="preferences" value={newParticipant.preferences.toString()} onChange={onChange} type="text" placeholder="1, 2, 3" />
        <input type="submit" value="Add" />
      </form>
      <button onClick={() => getAssignments()}>Organize</button>
      <div>
        <h3>Car Assignments</h3>
        {loadingAssignments && <p>Loading...</p>}
        <ul>
          {assignments && assignments.organize.map(car => 
            <li key={car.id}>{car.driver.name}: {car.riders.map(rider => rider.name)}</li>
          )}
        </ul>
      </div>
    </div>
  )
}

export default Overview
