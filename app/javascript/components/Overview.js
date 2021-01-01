import React, { useState } from "react";
import { ApolloClient, InMemoryCache, useQuery, useLazyQuery, gql } from "@apollo/client";
import Avatar from "./Avatar";
import styles from "./overview.module.css";

// NOTE: if this wasn't a SPA, ideally we'd include it in the router setup
// and pass it down using ApolloProvider
const client = new ApolloClient({
  uri: '/graphql',
  cache: new InMemoryCache()
});

const ALL_PEOPLE = gql`
  query allPeople {
    allRiders {
      id
      name
      address
      preferences {
        name
      }
    }
    allDrivers {
      id
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
        return val.split(',').map(el => (el.trim())) // TODO: tidy up edge case
      default: 
        return val;
    }
  }

  const onAddParticipant = (event) => {
    event.preventDefault();
    console.log(newParticipant);

    // TODO: add mutation
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
    <div className={styles.main}>
      <div className={styles.layout}>
        <h1>Participants</h1>
        <p><b>Riders ({data && data.allRiders.length}):</b></p>
        <ul>
          {
          data && data.allRiders.map(rider => 
              <li key={rider.id}>
                <Avatar id={rider.id} name={rider.name} address={rider.address} />
              </li>
            )
          }
        </ul>
        <p><b>Drivers ({data && data.allDrivers.length}):</b></p>
        <ul>
          {
          data && data.allDrivers.map(driver => 
              <li key={driver.name}>
                <Avatar id={driver.id} name={driver.name} address={driver.address} />
              </li>
            )
          }
        </ul>
        <form className={styles.form} onSubmit={onAddParticipant}>
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
    </div>
  )
}

export default Overview
