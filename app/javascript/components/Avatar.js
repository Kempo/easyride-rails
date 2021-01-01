import React from "react";
import styles from "./avatar.module.css";

function Avatar({ id, name, address }) {

  return (
    <div className={styles.avatar}>
      <img src={`https://avatars.dicebear.com/4.5/api/male/${id}${name}.svg`} alt={`Avatar for Person ${id}`} />
      <h4>{name}</h4>
      <p>{address}</p>
    </div>
  )
}

export default Avatar