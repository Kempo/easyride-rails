import React from "react"
import { ApolloProvider, ApolloClient, InMemoryCache, useQuery, gql } from "@apollo/client";

const client = new ApolloClient({
  uri: '/graphql',
  cache: new InMemoryCache()
});

const QUERY = gql`
  query allPosts {
    allRiders {
      name
      address
      preferences {
        name
        address
      }
    }
  }
`;

function Overview({ someParam }) {

  const { loading, error, data } = useQuery(QUERY, { client });

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
    </div>
  )
}

export default Overview
