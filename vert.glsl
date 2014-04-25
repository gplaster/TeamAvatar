uniform vec3 dColor;

attribute vec3 aPosition;
attribute vec3 aNormal;

uniform mat4 uProjMatrix;
uniform mat4 uViewMatrix;
uniform mat4 uModelMatrix;
uniform vec3 uLPos;
uniform float uOutline;

varying vec4 fNormal;
varying vec3 fColor;
varying vec4 fPos;

void main() {
  vec4 vPosition;
  /* First model transforms */
  vPosition = vec4(aPosition, 1.0);
  if(uOutline > 0.5) {
    vPosition = vec4(aPosition + normalize(aNormal) * 0.02, 1.0);
  }
  vPosition = uModelMatrix * vPosition;
  vPosition = uViewMatrix * vPosition;
  fPos = vPosition;
  gl_Position = uProjMatrix * vPosition;

  //apply model translations to normals and normalize them
  vec4 rotatedNormal = normalize(uModelMatrix * vec4(aNormal.x, aNormal.y, aNormal.z, 0.0));
  fNormal = rotatedNormal;
}
