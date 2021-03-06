struct Oscillator
{	
float3 CurrentPos;
float3 PreviousPos;	
float3 CurrentVel;
float3 PreviousVel;	
};

StructuredBuffer<Oscillator> OscillatorIn;
RWStructuredBuffer<float3> Output : BACKBUFFER;

int threadCount;


[numthreads(64, 1, 1)]
void CSpos( uint3 dtid : SV_DispatchThreadID)
{ 
	if (dtid.x > threadCount) { return; }
	Output[dtid.x] = OscillatorIn[dtid.x].CurrentPos;
}




technique11 Read
{
	pass P0
	{
		SetComputeShader( CompileShader( cs_5_0, CSpos() ) );
	}
}





