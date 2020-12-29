import React from "react"
import { ApolloClient, InMemoryCache, useQuery, gql } from "@apollo/client";

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

const ALL_ASSIGNMENTS = gql`
  query fetchAssignments {
    organize {
      driver {
        name
      }
      riders {
        name
      }
    }
  }
`;

function Overview({ someParam }) {

  const { loading, error, data } = useQuery(ALL_PEOPLE, { client });

  if (loading) {
    return <div>Loading...</div>
  }

  if (error) {
    return <div>Error!</div>
  }

  return (
    <div>
      <h1>Assignments</h1>
      <p>Aaron Chen (Status: {someParam ? 'Signed in.' : 'Unauthenticated.'})</p>
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
      <form>
        <input type="text" placeholder="Name" />
        <input type="text" placeholder="Address" />
        <input type="submit" value="Submit" />
      </form>
    </div>
  )
}

export default Overview
